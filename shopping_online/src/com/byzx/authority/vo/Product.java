package com.byzx.authority.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Product implements Serializable{
	
	//与ShopStore关联，关系1-1
	private ShopStore shopStore;
    public ShopStore getShopStore() {
		return shopStore;
	}
	public void setShopStore(ShopStore shopStore) {
		this.shopStore = shopStore;
	}
	//与brand表关联，关系1-1
	private Brand brand;
	public Brand getBrand() {
		return brand;
	}
	public void setBrand(Brand brand) {
		this.brand = brand;
	}
	//与分类表关联 ，关系1-1
	private ProType proType;
	public ProType getProType() {
		return proType;
	}
	public void setProType(ProType proType) {
		this.proType = proType;
	}
	
	
	
	//模糊查询中的商品类型
	private String typeName;
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	private Integer proId;

    private Integer storeId;

    private Integer typeId;

    private Integer brandId;

    private String proName;

    private Integer proSupply;

    private Integer proAddress;

    private Integer sellCount;

    private String proPic;

    private Integer inventory;

    private String proUpDown;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date proStartDate;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date proEndDate;

    private String isPlat;

    private Date createTime;

    private String proInfo;

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

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName == null ? null : proName.trim();
    }

    public Integer getProSupply() {
        return proSupply;
    }

    public void setProSupply(Integer proSupply) {
        this.proSupply = proSupply;
    }

    public Integer getProAddress() {
        return proAddress;
    }

    public void setProAddress(Integer proAddress) {
        this.proAddress = proAddress;
    }

    public Integer getSellCount() {
        return sellCount;
    }

    public void setSellCount(Integer sellCount) {
        this.sellCount = sellCount;
    }

    public String getProPic() {
        return proPic;
    }

    public void setProPic(String proPic) {
        this.proPic = proPic == null ? null : proPic.trim();
    }

    public Integer getInventory() {
        return inventory;
    }

    public void setInventory(Integer inventory) {
        this.inventory = inventory;
    }

    public String getProUpDown() {
        return proUpDown;
    }

    public void setProUpDown(String proUpDown) {
        this.proUpDown = proUpDown == null ? null : proUpDown.trim();
    }

    public Date getProStartDate() {
        return proStartDate;
    }

    public void setProStartDate(Date proStartDate) {
        this.proStartDate = proStartDate;
    }

    public Date getProEndDate() {
        return proEndDate;
    }

    public void setProEndDate(Date proEndDate) {
        this.proEndDate = proEndDate;
    }

    public String getIsPlat() {
        return isPlat;
    }

    public void setIsPlat(String isPlat) {
        this.isPlat = isPlat == null ? null : isPlat.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getProInfo() {
        return proInfo;
    }

    public void setProInfo(String proInfo) {
        this.proInfo = proInfo == null ? null : proInfo.trim();
    }
    
    
    
    
    
	@Override
	public String toString() {
		return "Product [shopStore=" + shopStore + ", typeName=" + typeName + ", proId=" + proId + ", storeId="
				+ storeId + ", typeId=" + typeId + ", brandId=" + brandId + ", proName=" + proName + ", proSupply="
				+ proSupply + ", proAddress=" + proAddress + ", sellCount=" + sellCount + ", proPic=" + proPic
				+ ", inventory=" + inventory + ", proUpDown=" + proUpDown + ", proStartDate=" + proStartDate
				+ ", proEndDate=" + proEndDate + ", isPlat=" + isPlat + ", createTime=" + createTime + ", proInfo="
				+ proInfo + ", getShopStore()=" + getShopStore() + ", getTypeName()=" + getTypeName() + ", getProId()="
				+ getProId() + ", getStoreId()=" + getStoreId() + ", getTypeId()=" + getTypeId() + ", getBrandId()="
				+ getBrandId() + ", getProName()=" + getProName() + ", getProSupply()=" + getProSupply()
				+ ", getProAddress()=" + getProAddress() + ", getSellCount()=" + getSellCount() + ", getProPic()="
				+ getProPic() + ", getInventory()=" + getInventory() + ", getProUpDown()=" + getProUpDown()
				+ ", getProStartDate()=" + getProStartDate() + ", getProEndDate()=" + getProEndDate() + ", getIsPlat()="
				+ getIsPlat() + ", getCreateTime()=" + getCreateTime() + ", getProInfo()=" + getProInfo()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}













}