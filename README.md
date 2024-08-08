# eshop-java

This project was developed during my second year of a Computer Science degree with the goal of building a prototype e-commerce website to understand the fundamentals of web applications.


Technologies Used:
- Java
- - JSP (JavaServer Pages)
- JDBC (Java Database Connectivity)
- JavaScript
- CSS
- HTML
- MySQL

  
Project Overview:
The application connects to a MySQL database where it stores data related to products, user details, reviews, partners, sizes, transactions, and sales. 
I used Eclipse IDE for this project, mainly to explore a different environment compared to my usual use of VSCode. 
The repository includes all Eclipse-generated files, as well as SQL queries necessary for database creation.


Application Workflow:

Users start by creating an account, where validation checks are in place to prevent the submission of fake details. 
While browsing the product catalog is allowed without logging in, certain features, such as viewing account details, require authentication.
To log in, users must provide their username and password. The backend then verifies the credentials by decrypting the password stored in the database. 
This decryption is done using a simple substitution cipher, where each letter is shifted three positions forward in the alphabet (e.g., A becomes D, B becomes E).
Once the username and password are validated, a session is established, allowing the user to view account details or proceed with purchasing products.


Note: While I aimed to create a functional and visually appealing frontend, the primary focus of this project was on developing the backend functionality.
