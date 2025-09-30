import 'package:flutter/material.dart';
import 'package:kuis_prak_mobile/models/animal_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final Animal animal;
  const DetailScreen({super.key, required this.animal});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<void> _viewWikiDetails(Uri link) async {
    if (!await launchUrl(link)) {
      throw Exception('Could not launch $link');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          widget.animal.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                widget.animal.isFav = !widget.animal.isFav;
              });
            },
            icon:
                widget.animal.isFav
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_outline),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(child: Image.network(widget.animal.image)),
              SizedBox(height: 10),
              Text(
                "${widget.animal.name} (${widget.animal.type})",
                overflow: TextOverflow.visible,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 5),
              Text(
                "Animal Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "Weight : ${widget.animal.weight} Kg",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Text(
                "Height : ${widget.animal.height} cm",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                "Habitats",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      widget.animal.habitat.map((hb) {
                        return Container(
                          margin: EdgeInsets.only(right: 4),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            hb,
                            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                ),
              ),
              SizedBox(height: 15,),
              Text(
                "Activities",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      widget.animal.activities.map((act) {
                        return Container(
                          margin: EdgeInsets.only(right: 4),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            act,
                            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ) 
              ),
              onPressed: () {
                _viewWikiDetails(Uri.parse(widget.animal.wikipedia));
              },
              child: Text(
                "Wikipedia Detail",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
