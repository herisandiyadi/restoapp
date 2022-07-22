import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant_detail_args.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/ui/home/home_page.dart';

class ReviewPage extends StatelessWidget {
  final nameController = TextEditingController();
  final reviewController = TextEditingController();
  final ReviewArgs reviewArgs;

  ReviewPage({Key? key, required this.reviewArgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          title: Text(
            'Tambah Ulasan',
            style: darkTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: darkColor,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        body: Container(
          margin: EdgeInsets.only(top: 30, right: 20, left: 20),
          child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama',
                      style: darkTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      height: 44,
                      width: double.infinity,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Masukkan nama kamu',
                          hintStyle: greyTextStyle,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        controller: nameController,
                        style: darkTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ulasan',
                      style: darkTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 140,
                      width: double.infinity,
                      color: softGreyColor,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Masukkan ulasan kamu',
                          hintStyle: greyTextStyle,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        controller: reviewController,
                        maxLines: 5,
                        style: darkTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 55,
                  width: double.infinity,
                  color: greenColor,
                  child: TextButton(
                    onPressed: () async {
                      ApiService(client: Client()).addReview(reviewArgs.id,
                          nameController.text, reviewController.text);
                      Container(
                        child: Center(child: CircularProgressIndicator()),
                      );
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      // Navigator.pop(context);
                    },
                    child: Text(
                      'Submit',
                      style: whiteTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
