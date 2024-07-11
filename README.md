## E-Hotel App

E-Hotel is an application designed for the efficient management of hotel reservations, client relations, and hotel services. It provides a seamless experience for both hotel administrators and guests, ensuring smooth operations and excellent customer service.

### Key Features

- **User Authentication**:
  - Secure sign-up and login with email-based authentication.
  - Password reset and account management.

- **Reservation Management**:
  - Easy booking interface for guests.
  - Real-time updates on room availability and bookings.

- **Client Management**:
  - Comprehensive customer profiles and booking history.
  - Automated communication for confirmations, reminders, and promotions.

- **Service Management**:
  - Tools for managing various hotel services (e.g., room service, housekeeping).
  - Integration with payment gateways for smooth transactions.

### Technologies

- **Backend**: Django, Django REST Framework, Simple JWT.
- **Frontend**: Flutter.
- **Database**: PostgreSQL.
- **Mapping**: OpenStreetMap.

### Installation

1. **Clone the repository**:
   ```sh
   git clone https://github.com/yourusername/E-Hotel.git
   cd E-Hotel
   ```

2. **Backend Setup**:
   ```sh
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   python manage.py migrate
   python manage.py runserver
   ```

3. **Frontend Setup**:
   ```sh
   cd flutter_app
   flutter pub get
   flutter run
   ```

### Contribution

We welcome contributions! Please fork the repository and submit a pull request.

### License

This project is licensed under the MIT License.

### Contact

For inquiries, contact [Elaidat Mohamed Redha](mailto:ridaelaidate7@gmail.com).
