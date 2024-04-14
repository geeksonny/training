package com.training.ch.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.Objects;


public class User {
    private int uno;
    private String id;
    private String pwd;
    private String name;
    private String email;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birth;
    private Date reg_date;

    @Override
    public String toString() {
        return "User{" +
                "uno=" + uno +
                ", id='" + id + '\'' +
                ", pwd='" + pwd + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", birth=" + birth +
                ", reg_date=" + reg_date +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return uno == user.uno && Objects.equals(id, user.id) && Objects.equals(pwd, user.pwd) && Objects.equals(name, user.name) && Objects.equals(email, user.email) && Objects.equals(birth, user.birth) && Objects.equals(reg_date, user.reg_date);
    }

    @Override
    public int hashCode() {
        return Objects.hash(uno, id, pwd, name, email, birth, reg_date);
    }

    public User(){}

    public User(int uno,String id, String pwd, String name, String email, Date birth, Date reg_date) {
        this.uno = uno;
        this.id = id;
        this.pwd = pwd;
        this.name = name;
        this.email = email;
        this.birth = birth;
        this.reg_date = reg_date;
    }
    public int getUno() {
        return uno;
    }

    public void setUno(int uno) {
        this.uno = uno;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public Date getReg_date() {
        return reg_date;
    }

    public void setReg_date(Date reg_date) {
        this.reg_date = reg_date;
    }

   }
