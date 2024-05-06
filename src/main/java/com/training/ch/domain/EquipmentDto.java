package com.training.ch.domain;

import java.util.Objects;

public class EquipmentDto {

    private int eno;
    private String eName;
    private int eCategory;      // 0: 상체 1:하체 2: 유산소
    private String eMainimg;
    private String eSubimg;
    private int eState;         // 0:예약가능 1:점검 중




    public EquipmentDto(){}
    public EquipmentDto(int eno, String eName, int eCategory, String eMainimg, String eSubimg, int eState) {
        this.eno = eno;
        this.eName = eName;
        this.eCategory = eCategory;
        this.eMainimg = eMainimg;
        this.eSubimg = eSubimg;
        this.eState = eState;
    }

    @Override
    public String toString() {
        return "EquipmentDto{" +
                "eno=" + eno +
                ", eName='" + eName + '\'' +
                ", eCategory=" + eCategory +
                ", eMainimg='" + eMainimg + '\'' +
                ", eSubimg='" + eSubimg + '\'' +
                ", eState=" + eState +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        EquipmentDto that = (EquipmentDto) o;
        return eno == that.eno && eCategory == that.eCategory && eState == that.eState && Objects.equals(eName, that.eName) && Objects.equals(eMainimg, that.eMainimg) && Objects.equals(eSubimg, that.eSubimg);
    }

    @Override
    public int hashCode() {
        return Objects.hash(eno, eName, eCategory, eMainimg, eSubimg, eState);
    }

    public int getEno() {
        return eno;
    }

    public void setEno(int eno) {
        this.eno = eno;
    }

    public String geteName() {
        return eName;
    }

    public void seteName(String eName) {
        this.eName = eName;
    }

    public int geteCategory() {
        return eCategory;
    }

    public void seteCategory(int eCategory) {
        this.eCategory = eCategory;
    }

    public String geteMainimg() {
        return eMainimg;
    }

    public void seteMainimg(String eMainimg) {
        this.eMainimg = eMainimg;
    }

    public String geteSubimg() {
        return eSubimg;
    }

    public void seteSubimg(String eSubimg) {
        this.eSubimg = eSubimg;
    }

    public int geteState() {
        return eState;
    }

    public void seteState(int eState) {
        this.eState = eState;
    }
}
