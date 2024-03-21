import '../../models/model.dart';

class ServiceManager {
  List<Service> services;

  ServiceManager(this.services);

  // Sorts the list of services based on categories and returns the sorted list
  List<Service> sortServicesByCategory() {
    List<Service> sortedServices = List.from(services)
      ..sort((a, b) => a.category.compareTo(b.category));
    return sortedServices
      ..toSet()
      ..toList();
  }

  // Returns the list of available categories containing a keyword
  List<String> getAvailableCategoriesWithKeyword(String keyword) {
    List<String> availableCategories = services
        .map((service) => service.category)
        .where((category) => category.contains(keyword))
        .toSet()
        .toList();
    return availableCategories;
  }

  // Returns the categories that don't contain any keyword from the collection
  List<String> getCategoriesWithoutKeywords(List<String> keywords) {
    List<String> categoriesWithoutKeywords = services
        .map((service) => service.category)
        .where((category) => !keywords.any((keyword) =>
            category.toLowerCase().contains(keyword.toLowerCase())))
        .toSet()
        .toList();
    return categoriesWithoutKeywords;
  }

  // Returns a list of distinct service categories using a particular keyword
  List<String> getServiceCategoriesWithKeyword(String keyword) {
    List<String> serviceCategoriesWithKeyword = services
        .where((service) =>
            service.category.toLowerCase().contains(keyword.toLowerCase()))
        .map((service) => service.category)
        .toSet()
        .toList();
    return serviceCategoriesWithKeyword;
  }

  // Returns a list of services with a particular category name as a keyword
  List<Service> getServicesByCategoryKeyword(String categoryKeyword) {
    List<Service> servicesByCategoryKeyword = services
        .where((service) => service.category == categoryKeyword)
        .toList();
    return servicesByCategoryKeyword;
  }

  Service? getServiceById(String serviceId) {
    // Use the map method to find the service with the matching serviceId
    var matchingServices =
        services.where((serv) => serv.serviceId == serviceId);

    // If any matching service is found, return the first one; otherwise, return null.
    return matchingServices.isNotEmpty ? matchingServices.first : null;
  }
}
