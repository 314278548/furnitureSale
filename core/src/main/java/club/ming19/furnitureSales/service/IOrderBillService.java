package club.ming19.furnitureSales.service;

import club.ming19.furnitureSales.domain.OrderBill;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.OrderBillQueryObject;

import java.util.List;

public interface IOrderBillService {
    int saveOrderBill(OrderBill bill);

    int updateStateToCancelBill(Long id, int state);

    Long getCountOfState(Long id, int state);

    PageResult<OrderBill> queryBillsByStateAndUid(OrderBillQueryObject qo);

    void delete(String id);

    List<OrderBill> getBillByID(Long id);
}
