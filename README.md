## E-Hotel App

E-Hotel is an innovative application designed to streamline and optimize the management of hotel reservations, client relations, and various hotel services. It provides a seamless experience for both hotel administrators and guests, ensuring smooth operations, excellent customer service, and efficient resource management.

### Key Features

- **User Authentication**:
  - Secure sign-up and login with email-based authentication.
  - Password reset and account management to ensure user security and convenience.

- **Reservation Management**:
  - An intuitive booking interface for guests to easily make reservations.
  - Real-time updates on room availability, enabling quick and accurate bookings.
  - Automated booking confirmations and reminders to enhance guest experience.

- **Client Management**:
  - Comprehensive customer profiles, including personal information, booking history, and preferences.
  - Tools for maintaining client relationships through personalized communication and offers.
  - Automated notifications for check-in/check-out, special promotions, and loyalty programs.

- **Service Management**:
  - Efficient management of hotel services such as room service, housekeeping, and maintenance.
  - Integration with payment gateways for smooth and secure transactions.
  - Real-time tracking and reporting of service requests to ensure prompt response and resolution.

- **Administrative Tools**:
  - Dashboards and analytics for monitoring hotel performance, occupancy rates, and revenue.
  - Staff management features to schedule shifts, assign tasks, and track performance.
  - Inventory management for monitoring supplies and managing procurement.

### Technologies

- **Backend**: Django, Django REST Framework, Simple JWT.
- **Frontend**: Flutter.
- **Database**: PostgreSQL.
- **Mapping**: OpenStreetMap for location-based services and navigation.

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
