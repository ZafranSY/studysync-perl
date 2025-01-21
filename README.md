# StudySync Perl Backend

---

## Overview
The **StudySync Perl Backend** provides the server-side logic and database integration for the StudySync platform. Built using **Mojolicious**, this backend ensures efficient handling of academic data and seamless communication between students and lecturers.

---

## Goals
1. **Reliability:** Provides a robust backend to handle API requests and ensure seamless data transfer.
2. **Integration:** Manages interactions with the **MariaDB** database for efficient storage and retrieval of data.
3. **Scalability:** Designed to support a growing number of users and interactions.

---

## Features
- **RESTful APIs:** Endpoints for managing user authentication, notifications, and updates.
- **Database Integration:** Efficient CRUD operations with MariaDB.
- **Real-time Communication:** Supports instant updates through WebSocket integration.
- **Secure Data Handling:** Implements secure practices for data access and user management.

---

## Prerequisites
- **WSL** or **Docker** with `mariadb:latest`.
- Perl (5.10 or later).
- Mojolicious framework.

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/studysync-perl.git
   ```

2. Navigate to the backend directory:
   ```bash
   cd studysync-perl
   ```

3. Set up MariaDB using Docker:
   ```bash
   docker run --name studysync-mariadb -e MYSQL_ROOT_PASSWORD=yourpassword -e MYSQL_DATABASE=studysync -p 3306:3306 -d mariadb:latest
   ```

4. Install Perl dependencies:
   ```bash
   cpan Mojolicious DBI DBD::mysql
   ```

5. Configure the database connection in `config/database.conf`:
   ```ini
   [database]
   host = 127.0.0.1
   port = 3306
   user = root
   password = yourpassword
   database = studysync
   ```

---

## Running the Server

1. Start the backend server:
   ```bash
   perl daemon working.pl http://*:80
   ```

2. The server will be accessible at:
   ```
   http://localhost:80
   ```

3. Use tools like **Postman** or a web browser to test API endpoints.

---

## Usage

- After setting up, the backend will:
  1. Handle API requests from the Vue.js frontend.
  2. Manage real-time notifications and data synchronization.
  3. Provide endpoints for user management, updates, and forums.

---

## Folder Structure
- **`/lib`**: Contains Mojolicious controllers and helpers.
- **`/public`**: Static assets like images and JavaScript files.
- **`/templates`**: Embedded Perl (EP) templates for rendering views.
- **`/config`**: Configuration files, including database settings.

---

## API Documentation
Visit the `/api-docs` endpoint after running the server to access the detailed API documentation.

---

## Contributing
Contributions are welcome! Follow these steps:
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature-name"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Create a Pull Request.

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact
For further inquiries, please contact us at [zafranzafran0234@gmail.com](mailto:zafranzafran0234@gmail.com).

---

## Acknowledgments
- **University of Technology Malaysia (UTM):** Inspiration and support.
- **Perl Community:** Framework and documentation.
