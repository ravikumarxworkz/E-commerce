

```markdown
# 🛒 Spring Boot E-Commerce Web Application

A simple and functional E-Commerce web application built using **Spring Boot**, **Spring Security with JWT**, **JSP**, **MySQL**, and **jQuery + Bootstrap** for the frontend. It supports **admin** and **customer** roles with JWT-based login and dynamic dashboards.

---

## 🚀 Features

### 👤 Customer
- View all products
- Add products to cart
- Update/remove cart items
- Place orders
- View past orders
- Secure login with JWT
- Dashboard with navbar and logout

### 👨‍💼 Admin
- View all products
- Add new products
- Edit existing products
- Delete products
- Secure login with JWT
- Separate admin dashboard

---

## 🛠 Technologies Used

| Layer        | Tech Stack                         |
|-------------|-------------------------------------|
| Backend      | Java, Spring Boot, Spring MVC       |
| Security     | Spring Security with JWT Authentication |
| Frontend     | JSP, Bootstrap 5, jQuery            |
| Database     | MySQL                              |
| ORM          | Spring Data JPA (Hibernate)         |
| Tools        | Maven, IntelliJ / Eclipse, Postman  |

---

## 📁 Folder Structure

```

src
├── main
│   ├── java
│   │   └── com.commerce
│   │       ├── controller
│   │       ├── entity
│   │       ├── repository
│   │       ├── security
│   │       └── service
│   ├── resources
│   │   ├── application.properties
│   │── webapp/WEB-INF/views (JSP)

````

---

## ⚙️ Setup Instructions

1. **Clone the Repository**

```bash
git clone [https://github.com/your-username/ecommerce-springboot.git](https://github.com/ravikumarxworkz/E-commerce)
cd ecommerce-springboot
````

2. **Update MySQL Configuration**

Edit `src/main/resources/application.properties`:

```properties
spring.application.name=E-commerce
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/ecommerces?createDatabaseIfNotExist=true
spring.datasource.username=root
spring.datasource.password=password 

#vendorax?createDatabaseIfNotExist=true
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQLDialect

server.servlet.context-path=/E-commerce

# JSP view resolver configuration
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp
server.port=8080
server.error.whitelabel.enabled=false
server.error.path=/error


logging.level.org.springframework.security=DEBUG
spring.main.allow-bean-definition-overriding=true


```

3. **Run the Application**

```bash
mvn spring-boot:run
```

4. **Visit the Application**

* Customer login: `http://localhost:8080/E-commerce/login-page`
* Admin login: `http://localhost:8080/E-commerce/login-page`
* Example Admin User:

  * Username: `admin`
  * Password: `admin123`

---

## 🧩 Future Enhancements

* Product image upload
* Pagination & filters
* Stripe/Razorpay payment gateway integration
* Email order confirmation
* Responsive mobile UI
* Docker containerization

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

## ✍️ Author

[Ravikumar Kumbar](https://ravikumarxworkz.github.io/)

