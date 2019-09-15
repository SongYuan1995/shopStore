package com.byzx.authority.vo;

public class DeliverList {
	//主键
    private Integer deliverId;
    //订单id
    private Integer orderId;
    //发货单号
    private String deliverNum;
    //skuid
    private Integer skuId;
    //发货状态
    private String state;
    //物流信息
    private String deliverInfo;
    //备注
    private String remark;

    public Integer getDeliverId() {
        return deliverId;
    }

    public void setDeliverId(Integer deliverId) {
        this.deliverId = deliverId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getDeliverNum() {
        return deliverNum;
    }

    public void setDeliverNum(String deliverNum) {
        this.deliverNum = deliverNum == null ? null : deliverNum.trim();
    }

    public Integer getSkuId() {
        return skuId;
    }

    public void setSkuId(Integer skuId) {
        this.skuId = skuId;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public String getDeliverInfo() {
        return deliverInfo;
    }

    public void setDeliverInfo(String deliverInfo) {
        this.deliverInfo = deliverInfo == null ? null : deliverInfo.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
}