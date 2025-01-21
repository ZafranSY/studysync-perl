# StudySync Perl Backend - File and Folder Structure

This README provides details about the file and folder structure of the **StudySync Perl Backend** project and their respective purposes.

---

## Folder Structure
### **Root Directory**
- **`.dockerignore`**
  - Specifies files and directories to ignore when building Docker images.

- **`.gitattributes`**
  - Defines repository attributes for handling files (e.g., line endings).

- **`.github`**
  - Contains GitHub-specific configurations, such as workflows for CI/CD.

- **`Dockerfile`**
  - Used to build the Docker image for the backend.

- **`docker-compose.yml`**
  - Docker Compose configuration file for orchestrating multi-container setups (e.g., backend and database).

- **`README.md`**
  - Project documentation, including setup, features, and usage.

---

### **SQL Files**
- **`createtable.sql`**
  - SQL script for creating the required database tables.

- **`droptable.sql`**
  - SQL script for dropping tables, useful during database resets.

- **`dummydata.sql`**
  - Contains dummy data for populating the database during testing.

---

### **Perl Files**
- **`CRUD.pl`**
  - Implements Create, Read, Update, and Delete operations for managing database records.

- **`server.pl`**
  - Main server script that initializes the Mojolicious application and handles routing.

---

### **JavaScript Files**
- **`postTest.js`**
  - A script for testing API endpoints. Can be executed in Node.js or used as a reference for Postman or `curl`.

- **`tempCodeRunnerFile.js`**
  - Temporary file generated by code editors for testing snippets.

- **`todo.js`**
  - A utility file for tracking features or debugging tasks.

---

### **Other Files**
- **`exampleEndpointOutput.md`**
  - Documents sample outputs from various API endpoints for reference.

---

## Testing
### API Testing
1. **Using `postTest.js`:**
   - Navigate to the project directory and run the script:
     ```bash
     node postTest.js
     ```

2. **Using `curl`:**
   - Example `curl` command for testing:
     ```bash
     curl -X POST http://localhost:80/api/exampleEndpoint -d '{"key":"value"}' -H "Content-Type: application/json"
     ```

3. **Using Postman:**
   - Import API details into Postman and test endpoints interactively.

---

## Setup Guide
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/studysync-perl.git
   ```

2. Start the backend using Docker:
   ```bash
   docker-compose up --build
   ```

3. Access the application at:
   ```
   http://localhost:80
   ```

---

## Contribution Guide
1. Fork and clone the repository.
2. Make your changes in a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Test your changes thoroughly using `postTest.js`, `curl`, or Postman.
4. Commit and push your changes:
   ```bash
   git commit -m "Add feature-name"
   git push origin feature-name
   ```
5. Create a Pull Request for review.

---

For further details or inquiries, refer to the main **README.md** or contact the project maintainers.
