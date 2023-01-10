package service;

import dao.OrderDao;

import dao.RoomDao;
import dao.UserInfoDao;
import dto.OrderDto;
import dto.RoomDto;
import entity.Enum.ConditionEnum;
import entity.Enum.RoomStatusEnum;
import entity.Order;
import lombok.NoArgsConstructor;
import mapper.CreateOrderMapper;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.toList;
import static lombok.AccessLevel.PRIVATE;

@NoArgsConstructor(access = PRIVATE)
public class OrderService {

    private static final OrderService INSTANCE = new OrderService();
    private final OrderDao orderDao = OrderDao.getInstance();

    private final RoomDao roomDao = RoomDao.getInstance();
    private final CreateOrderMapper createOrderMapper = CreateOrderMapper.getInstance();
//    private final CreateOrderValidator createOrderValidator = CreateOrderValidator.getInstance();

    public Integer create(OrderDto orderDto) {
        var orderEntity = createOrderMapper.mapFrom(orderDto);
        orderDao.save(orderEntity);
        return orderEntity.getId();
    }

    public List<OrderDto> findOrdersByUserId(Integer userId) {
        var orderDtos = findAll();
        return orderDtos.stream()
                .filter(orderDto -> orderDto.getUserInfo().equals(userId))
                .collect(Collectors.toList());
    }

    public List<OrderDto> findById(Integer id) {
        return orderDao.findById(id).stream()
                .map(order -> OrderDto.builder()
                        .id(order.getId())
                        .userInfo(order.getUserInfoId().getId())
                        .room(order.getRoom().getId())
                        .beginTimeOfTheOrder(order.getBeginTimeOfTheOrder().toString())
                        .endTimeOfTheOrder(order.getEndTimeOfTheOrder().toString())
                        .condition(order.getCondition().name())
                        .message(order.getMessage())
                        .build())
                .collect(toList());

    }


    public List<OrderDto> findAll() {
        return orderDao.findAll().stream()
                .map(order -> OrderDto.builder()
                        .id(order.getId())
                        .userInfo(order.getUserInfoId().getId())
                        .room(order.getRoom().getId())
                        .beginTimeOfTheOrder(order.getBeginTimeOfTheOrder().toString())
                        .endTimeOfTheOrder(order.getEndTimeOfTheOrder().toString())
                        .condition(order.getCondition().name())
                        .message(order.getMessage())
                        .build())
                .collect(toList());
    }

    public Order findOrderById(Integer id) {
        return orderDao.findById(id).orElseThrow();

    }

    public void checkAndConfirmOrder(Order order) {
        LocalDate beginTimeOfTheOrder = order.getBeginTimeOfTheOrder();
        LocalDate endTimeOfTheOrder = order.getEndTimeOfTheOrder();
        Integer dayPrice = roomDao.findById(order.getRoom().getId()).orElseThrow().getDayPrice();
        Long finalPrice = calculatePrice(dayPrice, beginTimeOfTheOrder, endTimeOfTheOrder);

        if (order.getCondition().equals(ConditionEnum.WANT_TO_RESERVE)) {
            String correctPeriodOfTheOrderMessage = "";
            if (isNotCorrectPeriodOfTheOrder(beginTimeOfTheOrder, endTimeOfTheOrder)) {
                correctPeriodOfTheOrderMessage = "Некорректные даты бронирования. Проверте даты";
            }

            String final_message = "Всё в порядке. ";
            ConditionEnum conditionEnum = ConditionEnum.APPROVED;

            if (isNotCorrectPeriodOfTheOrder(beginTimeOfTheOrder, endTimeOfTheOrder)) {
                conditionEnum = ConditionEnum.REJECTED;
                final_message = String.format("%s", correctPeriodOfTheOrderMessage);

            } else {
                order.getRoom().setStatus(RoomStatusEnum.Booked);
                roomDao.update(order.getRoom());
            }
            order.setCondition(conditionEnum);
            order.setMessage(final_message + "Итого к оплате (с учетом НДС): " + finalPrice);
            orderDao.update(order);

        }
    }

    public void setFreeStatusRoom(Order order) {
        if (order.getCondition().equals(ConditionEnum.APPROVED)) {
            order.getRoom().setStatus(RoomStatusEnum.Free);
            roomDao.update(order.getRoom());
            order.setCondition(ConditionEnum.WANT_TO_RESERVE);
            order.setMessage("комната свободна");
            orderDao.update(order);
        }
    }

    public void sendCancelMessage(Order order) {
        if (order.getCondition().equals(ConditionEnum.APPROVED)) {
            order.setMessage("Админ, отмените заказ. Спасибо");
            orderDao.update(order);
        }
    }

//    public void sendCancelMessage(Integer id) {
//        var order = orderDao.findById(id);
//        if (order.get().getCondition().equals(ConditionEnum.APPROVED)) {
//            order.get().setMessage("Админ, отмените заказ. Спасибо");
//            orderDao.update(order.get());
//        }
//    }

    private boolean isNotCorrectPeriodOfTheOrder(LocalDate beginTimeOfTheOrder, LocalDate endTimeOfTheOrder) {
        return (beginTimeOfTheOrder.isAfter(endTimeOfTheOrder));
    }

    private Long calculatePrice(Integer dayPrice, LocalDate beginTimeOfTheOrder, LocalDate endTimeOfTheOrder) {
        var days = ChronoUnit.DAYS.between(beginTimeOfTheOrder, endTimeOfTheOrder);
        return dayPrice * days;
    }
    public static OrderService getInstance() {
        return INSTANCE;
    }
}
