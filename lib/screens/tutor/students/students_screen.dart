import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/models/tutorship_model.dart';
import 'package:tutor_app/providers/tutorship_provider.dart';
import 'package:tutor_app/widgets/students/student_card.dart';
import 'package:tutor_app/widgets/students/tutorship_offer_tile.dart';

import '../../../constants/colors.dart';
import '../../../widgets/common/custom_appbar.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({Key? key}) : super(key: key);

  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const CustomAppBar(
            title: 'Students',
            backgroundColor: Colors.transparent,
            canPop: false,
            centerTitle: true,
          ),
          const SizedBox(height: 5),
          const TutorshipOffersTile(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              height: 8,
              thickness: 1,
            ),
          ),
          true
              ? Expanded(
                  child: StreamBuilder<List<Tutorship>>(
                    stream: Provider.of<TutorshipProvider>(context, listen: false).tutorshipStreams(context),
                    builder: (context, snapshot) {

                      

                      if(snapshot.connectionState==ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.data==null||snapshot.data!.isEmpty){
                        return Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Column(children: [
                          Text(
                            "You dont have any students at the moment",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: bodyTextColor.withOpacity(0.5)),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          
                        ]),
                      );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => StudentCard(tutorship: snapshot.data![index],),
                      );
                    }
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Image.asset('assets/images/inbox_placeholder.png'),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
