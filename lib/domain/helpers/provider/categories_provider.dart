import 'package:trawus/Models/category.dart';
import '../../../Models/enums/categories.dart';
import '../../../constants.dart';

class CategoriesProvider {
  List<Category> _categories = [
    Category(
        category: Categories.car_rental,
        title: "Car Rental Services",
        iconUrl: carRental,
        details:
            "This Category includes the services mostly related to the Car Rental."),
    Category(
        category: Categories.airline_ticket_reservation,
        title: "Airline Reservations",
        iconUrl: airlineTicketReservation,
        details:
            "This category includes the services mostly related to the airline ticket reservations"),
    Category(
        category: Categories.bus_ticket_reservation,
        title: "Bus Reservations",
        iconUrl: busTicketReservation,
        details:
            "This category includes the services related to the bus reservations"),
    Category(
        category: Categories.railway_ticket_reservation,
        title: "Rail Reservations",
        iconUrl: railwayTicketReservation,
        details:
            "This category includes the services related to the Train reservations"),
    Category(
        category: Categories.domestic_trips,
        title: "Domestic Trips",
        iconUrl: domesticTrips,
        details:
            "This category includes the services related to all the domestic tourism services except the personalized trips"),
    Category(
        category: Categories.international_trips,
        title: "International Trips",
        iconUrl: internationalTrips,
        details:
            "This category includes the services related to all the International"
            " tourism services except the personalized trips"),
    Category(
        category: Categories.trip_planner,
        title: "Personalized Trips",
        iconUrl: tripPlanner,
        details:
            "This category includes the services for the personalized trips."
            " A person would be able to plan a personalized trip with the assistance of a tourism company"),
  ];

  List<Category> get categories => _categories;
}
