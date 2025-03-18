
# StudySync Perl Backend
<p>Feel free to view our site, 
<a href="http://107.175.189.118:8080/login">StudySync Live</a>
</p>
<br/>
This repository contains the backend for the StudySync application. It provides the server-side logic, RESTful APIs, and database integration to handle academic data and real-time communication between students and lecturers.  
[StudySync Live](http://107.175.189.118:8080/login)

---

## Table of Contents

- [Overview](#overview)
- [Goals](#goals)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation and Setup](#installation-and-setup)
  - [Step 1: Clone the Repository](#step-1-clone-the-repository)
  - [Step 2: Set Up the Database (MariaDB)](#step-2-set-up-the-database-mariadb)
  - [Step 3: Install Perl Dependencies](#step-3-install-perl-dependencies)
  - [Step 4: Configure the Database Connection](#step-4-configure-the-database-connection)
- [Running the Server](#running-the-server)
  - [Direct Execution (Without Docker Compose)](#direct-execution-without-docker-compose)
  - [Using Docker Compose](#using-docker-compose)
- [User Management and Navigation](#user-management-and-navigation)
  - [Using an Existing User "mojo"](#using-an-existing-user-mojo)
  - [Creating User "mojo"](#creating-user-mojo)
  - [Running as Root (Without Creating a New User)](#running-as-root-without-creating-a-new-user)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Testing](#testing)
- [Contribution Guide](#contribution-guide)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

---

## Overview

The **StudySync Perl Backend** is built using the Mojolicious framework. It manages API requests, interacts with a MariaDB database for efficient data storage and retrieval, and supports real-time communication via WebSockets. This backend works in tandem with the StudySync Vue.js front end to form a complete academic platform.

---

## Goals

1. **Reliability:** Robustly handle API requests and data transfer.
2. **Integration:** Seamlessly interact with a MariaDB database.
3. **Scalability:** Support a growing user base and increasing interactions.
4. **Security:** Enforce secure practices for user management and data access.

---

## Features

- **RESTful APIs:** For user authentication, notifications, and data operations.
- **Database Integration:** Efficient CRUD operations with MariaDB.
- **Real-Time Communication:** WebSocket support for live updates.
- **Secure Data Handling:** Best practices in user management and data security.

---

## Prerequisites

- **Operating System:** Linux, macOS, or Windows (WSL recommended for Linux commands)
- **Docker:** Installed and running (for setting up MariaDB and optionally running the backend)
- **Perl (v5.10+):** With [Mojolicious](https://mojolicious.org/)
- **Basic Shell & Git Knowledge**

---

## Installation and Setup

### Step 1: Clone the Repository

Clone the repo to your local machine:

```bash
git clone https://github.com/ZafranSY/studysync-perl
cd studysync-perl
```

### Step 2: Set Up the Database (MariaDB)

**Option A: Run MariaDB with Docker**

Run the following command to start a MariaDB container:

```bash
docker run --name studysync-mariadb \
  -e MYSQL_ROOT_PASSWORD=yourpassword \
  -e MYSQL_DATABASE=studysync \
  -p 3306:3306 \
  -d mariadb:latest
```

**Option B: Use Docker Compose**

If a `docker-compose.yml` file is provided, run:

```bash
docker-compose up --build
```

### Step 3: Install Perl Dependencies

Install the necessary Perl modules using CPAN (or cpanminus):

```bash
cpan Mojolicious DBI DBD::mysql
```

*Tip:* If you encounter permissions issues, try running the command with `sudo` or as a user with appropriate privileges.

### Step 4: Configure the Database Connection

Edit the file `config/database.conf` to match your database settings:

```ini
[database]
host = 127.0.0.1
port = 3306
user = root
password = yourpassword
database = studysync
```

Replace `yourpassword` with the password you set for MariaDB.

---

## Running the Server

### Direct Execution (Without Docker Compose)

From the repository's root (or the backend directory), start the server with:

```bash
perl working.pl daemon -l http://*:80
```

The backend will be accessible at [http://localhost:80](http://localhost:80).

### Using Docker Compose

If your `docker-compose.yml` file sets up both the backend and MariaDB, run:

```bash
docker-compose up --build
```

This command builds the Docker image and starts all defined containers.

---

## User Management and Navigation

### Using an Existing User "mojo"

If your environment already has a user named **mojo**, follow these steps:

1. **Switch to user "mojo":**
   ```bash
   su - mojo
   ```
2. **Navigate to the StudySync directory:**  
   (Assuming it's located at `/home/mojo/studysync/testing`)
   ```bash
   cd ~/studysync/testing
   ```
3. **Start the Perl application:**
   ```bash
   perl working.pl daemon -l http://*:80
   ```
   *(Replace `working.pl` with your actual server script if different.)*

### Creating User "mojo"

If the **mojo** user does not exist and you want to create it, use the following commands:

1. **Create the user "mojo":**
   ```bash
   adduser mojo
   ```
2. **Create the necessary directory structure:**
   ```bash
   mkdir -p /home/mojo/studysync/testing
   ```
3. **Set ownership of the directory:**
   ```bash
   chown -R mojo:mojo /home/mojo/studysync/testing
   ```
4. **Switch to the "mojo" user:**
   ```bash
   su - mojo
   ```
5. **Navigate to the StudySync directory:**
   ```bash
   cd ~/studysync/testing
   ```
6. **Start the Perl application:**
   ```bash
   perl working.pl daemon -l http://*:80
   ```

### Running as Root (Without Creating a New User)

If you prefer not to create a new user (i.e., you do not have or want to use **mojo**), you can run the backend as the **root** user. Since the default home for root is `/root`, follow these steps:

1. **Stay as root or switch to root (if not already):**
   ```bash
   su -
   ```
2. **Navigate to your working directory (you can create one if needed):**
   ```bash
   mkdir -p /root/studysync
   cd /root/studysync
   ```
3. **Place or clone your StudySync backend here (if not already done) and run the server:**
   ```bash
   perl /path/to/studysync-perl/working.pl daemon -l http://*:80
   ```
   *(Adjust the path to `working.pl` as necessary.)*

---

## Usage

Once running, the backend will:

- Serve API requests from the StudySync front end.
- Handle real-time notifications and data synchronization.
- Provide endpoints for user management, updates, and forum interactions.

Test endpoints using **Postman**, **curl**, or your preferred API testing tool. For detailed API documentation, visit the `/api-docs` endpoint in your browser after starting the server.

---

## Folder Structure

- **`/lib`**: Contains Mojolicious controllers and helper modules.
- **`/public`**: Static assets (images, JavaScript, CSS).
- **`/templates`**: Embedded Perl templates for rendering views.
- **`/config`**: Configuration files, including `database.conf`.

### SQL Files

- **`createtable.sql`**: Script to create necessary database tables.
- **`droptable.sql`**: Script to drop tables (useful for resets).
- **`dummydata.sql`**: Dummy data for testing.

### Perl Files

- **`CRUD.pl`**: Implements CRUD operations.
- **`server.pl`**: Initializes the Mojolicious application.
- **`working.pl`**: Launches the backend server.

### Other Files

- **`postTest.js`**: For testing API endpoints.
- **`exampleEndpointOutput.md`**: Sample API responses.

---

## Testing

### API Testing (Backend)

- **Using `postTest.js`:**
  
  From the project directory, run:
  
  ```bash
  node postTest.js
  ```

- **Using `curl`:**
  
  Test an endpoint with:
  
  ```bash
  curl -X POST http://localhost:80/api/exampleEndpoint \
       -d '{"key":"value"}' \
       -H "Content-Type: application/json"
  ```

- **Using Postman:**
  
  Import the API endpoints and test them interactively.

---

## Contribution Guide

1. **Fork and Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/studysync-perl.git
   cd studysync-perl
   ```

2. **Create a New Branch:**

   ```bash
   git checkout -b feature-name
   ```

3. **Make and Test Your Changes:**

   Use `postTest.js`, `curl`, or Postman for backend testing.

4. **Commit and Push:**

   ```bash
   git commit -m "Add feature-name"
   git push origin feature-name
   ```

5. **Submit a Pull Request** for review.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact

For inquiries or issues, please contact [zafranzafran0234@gmail.com](mailto:zafranzafran0234@gmail.com).

---

## Acknowledgments

- **University of Technology Malaysia (UTM):** For inspiration and support.
- **Perl Community:** For the Mojolicious framework and comprehensive documentation.
- **All Contributors:** For testing, feedback, and code contributions.
```

---

This README now includes detailed instructions on how to set up, run, navigate, and manage users (including alternatives for using **mojo** or running as **root**) for the StudySync Perl Backend. Simply copy and use it in your repository, and you'll have everything you need for future reference.
