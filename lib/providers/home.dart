import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/models/serviceProviderOffer.dart';

class HomeProvider with ChangeNotifier {
  List<ServiceProviderOffer> serviceprovideroffers = [
    ServiceProviderOffer(
        image: 'https://media-cdn.tripadvisor.com/media/photo-s/0c/a3/67/9d/maestral-resort-casino.jpg',
        title: 'مثال لما يمكن عرضه فى هذا العنوان',
        desc: 'مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص ',
        priceA: '25 جنيه',
        priceB: '30 جنيه'),
    ServiceProviderOffer(
        image:
            'https://mostaql.hsoubcdn.com/uploads/thumbnails/835649/5fb1c7c34bc0a/Beauty-Centre-1.jpg',
        title: 'مثال لما يمكن عرضه فى هذا العنوان',
        desc:
            'مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص',
        priceA: '25 جنيه',
        priceB: '30 جنيه'),
    ServiceProviderOffer(
        image:
            'https://www.asianfusion-mag.com/wp-content/uploads/2016/04/unnamed-3.jpg',
        title: 'مثال لما يمكن عرضه فى هذا العنوان',
        desc:
            'مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص',
        priceA: '25 جنيه',
        priceB: '30 جنيه'),
    ServiceProviderOffer(
        image: 'https://boyemen.com/user_images/news/03-02-21-264128901.jpg',
        title: 'مثال لما يمكن عرضه فى هذا العنوان',
        desc:
            'مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص',
        priceA: '25',
        priceB: '30')
  ];
  List<ServiceProviderOffer> availableservices = [
    ServiceProviderOffer(
        image: 'https://cdn.cobone.com/deals/uae/127153/1-baravia-beauty-center-hair-packages.jpg?v=11',
        title: 'صالون مدام صفاء',
        desc: 'مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص ',
        priceA: '25 جنيه',
        priceB: '30 جنيه',
        rate: 4),
    ServiceProviderOffer(
        image:
            'https://www.asianfusion-mag.com/wp-content/uploads/2016/04/unnamed-3.jpg',
        title: 'صالون مدام صفاء',
        desc:
            'مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص',
        priceA: '25 جنيه',
        priceB: '30 جنيه',
        rate: 5),
    ServiceProviderOffer(
        image:
            'https://www.asianfusion-mag.com/wp-content/uploads/2016/04/unnamed-3.jpg',
        title: 'صالون مدام صفاء',
        desc:
            'مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص',
        priceA: '25 جنيه',
        priceB: '30 جنيه',
        rate: 3),
    ServiceProviderOffer(
        image: 'https://boyemen.com/user_images/news/03-02-21-264128901.jpg',
        title: 'صالون مدام صفاء',
        desc:
            'مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص مثال لما يمكن عرضه فى هذا النص',
        priceA: '25',
        priceB: '30',
        rate: 4)
  ];
}
