package app.model;

import org.springframework.web.multipart.MultipartFile;

import javax.persistence.Transient;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;


public class User {
    private int id;
    private String name,password,confirmpassword,mail,phone,address;
    private LocalDate created_date;
    private boolean locked;
    private int role_id;
    private String user_image_path;
    @Transient
    private MultipartFile multipartFile;
    private LocalDateTime subscriptionExpiration;



    public User(int id, String name, int role_id, LocalDateTime subscriptionExpiration) {
        this.id = id;
        this.name = name;
        this.role_id = role_id;
        this.subscriptionExpiration = subscriptionExpiration;
    }

    public User(int id, String name, String password, String confirmpassword, String mail, String phone, String address, LocalDate created_date, boolean locked, int role_id, String user_image_path, MultipartFile multipartFile, LocalDateTime subscriptionExpiration) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.confirmpassword = confirmpassword;
        this.mail = mail;
        this.phone = phone;
        this.address = address;
        this.created_date = created_date;
        this.locked = locked;
        this.role_id = role_id;
        this.user_image_path = user_image_path;
        this.multipartFile = multipartFile;
        this.subscriptionExpiration = subscriptionExpiration;
    }

    public LocalDateTime getSubscriptionExpiration() {
        return subscriptionExpiration;
    }

    public void setSubscriptionExpiration(LocalDateTime subscriptionExpiration) {
        this.subscriptionExpiration = subscriptionExpiration;
    }

    public User(int id, String name, String password, String confirmpassword, String mail, String phone, String address, LocalDate created_date, boolean locked, int role_id, String user_image_path, MultipartFile multipartFile) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.confirmpassword = confirmpassword;
        this.mail = mail;
        this.phone = phone;
        this.address = address;
        this.created_date = created_date;
        this.locked = locked;
        this.role_id = role_id;
        this.user_image_path = user_image_path;
        this.multipartFile = multipartFile;
    }

    public String getUser_image_path() {
        return user_image_path;
    }

    public void setUser_image_path(String user_image_path) {
        this.user_image_path = user_image_path;
    }

    public MultipartFile getMultipartFile() {
        return multipartFile;
    }

    public void setMultipartFile(MultipartFile multipartFile) {
        this.multipartFile = multipartFile;
    }

    public boolean isLocked() {
        return locked;
    }

    public void setLocked(boolean locked) {
        this.locked = locked;
    }

    public User(String name, String password, String confirmpassword, String mail, String phone, String address, LocalDate created_date, boolean locked, int role_id) {
        this.name = name;
        this.password = password;
        this.confirmpassword = confirmpassword;
        this.mail = mail;
        this.phone = phone;
        this.address = address;
        this.created_date = created_date;
        this.locked = locked;
        this.role_id = role_id;
    }

    public User(String name, String password, String confirmpassword, String mail, String phone, String address, int role_id) {
        this.name = name;
        this.password = password;
        this.confirmpassword = confirmpassword;
        this.mail = mail;
        this.phone = phone;
        this.address = address;
        this.role_id = role_id;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public User(String name, String password, String confirmpassword, String mail, String phone, String address, LocalDate created_date, int role_id) {
        this.name = name;
        this.password = password;
        this.confirmpassword = confirmpassword;
        this.mail = mail;
        this.phone = phone;
        this.address = address;
        this.created_date = created_date;
        this.role_id = role_id;
    }

    public User(int id, String name, String password, String confirmpassword, String mail, String phone, String address, LocalDate created_date, int role_id) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.confirmpassword = confirmpassword;
        this.mail = mail;
        this.phone = phone;
        this.address = address;
        this.created_date = created_date;
        this.role_id = role_id;
    }

    public User(LocalDate created_date) {
        this.created_date = created_date;
    }

    public User(String name, String password, String confirmpassword, String mail, String phone, String address) {
        this.name = name;
        this.password = password;
        this.confirmpassword = confirmpassword;
        this.mail = mail;
        this.phone = phone;
        this.address = address;
    }

    public User() {
    }

    public User(String name, String password, String confirmpassword, String mail, String phone, String address, LocalDate created_date) {
        this.name = name;
        this.password = password;
        this.confirmpassword = confirmpassword;
        this.mail = mail;
        this.phone = phone;
        this.address = address;
        this.created_date = created_date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmpassword() {
        return confirmpassword;
    }

    public void setConfirmpassword(String confirmpassword) {
        this.confirmpassword = confirmpassword;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public User(int id, String name, String password, String confirmpassword, String mail, String phone, String address, LocalDate created_date) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.confirmpassword = confirmpassword;
        this.mail = mail;
        this.phone = phone;
        this.address = address;
        this.created_date = created_date;
    }

    public LocalDate getCreated_date() {
        return created_date;
    }

    public void setCreated_date(LocalDate created_date) {
        this.created_date = created_date;
    }

    // Add this field to the User class if you want to track reactions made by the user
    private List<Reaction> reactionsMade;

    // Getter and setter for reactionsMade
    public List<Reaction> getReactionsMade() {
        return reactionsMade;
    }

    public void setReactionsMade(List<Reaction> reactionsMade) {
        this.reactionsMade = reactionsMade;
    }
}