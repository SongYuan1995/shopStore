package com.byzx.authority.vo;

import java.util.Date;

public class OrderItem {
	 //明细id
    private Integer itemId;
    //订单id
    private Integer orderId;
   // 商品id
	private Integer proId;
	//店铺id
    private Integer storeId;
    //skuid
    private Integer skuId;
    //商品名称
    private String proName;
    //商品价格
    private Float proPrice;
    //商品数量
    private Integer proCount;
    //商品小计
    private Float proTotal;
    //创建时间
    private Date createTime;
    //备注
    private String remark;
    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getSkuId() {
        return skuId;
    }

    public void setSkuId(Integer skuId) {
        this.skuId = skuId;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName == null ? null : proName.trim();
    }

    public Float getProPrice() {
        return proPrice;
    }

    public void setProPrice(Float proPrice) {
        this.proPrice = proPrice;
    }

    public Integer getProCount() {
        return proCount;
    }

    public void setProCount(Integer proCount) {
        this.proCount = proCount;
    }

    public Float getProTotal() {
        return proTotal;
    }

    public void setProTotal(Float proTotal) {
        this.proTotal = proTotal;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
}