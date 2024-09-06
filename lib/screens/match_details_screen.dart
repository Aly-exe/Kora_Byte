import 'package:flutter/material.dart';

// class MatchDetailsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.0), // Set height of the AppBar
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xff2412C0),
//                 Color(0xff4910BC)
//               ], // Define your gradient colors
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: AppBar(
//             backgroundColor:
//                 Colors.transparent, // Set AppBar background to transparent
//             elevation: 0,
//             title: Text(
//               'Match Details',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           // Champion, Round, Date, Time
//           buildMatchInfoSection(),

//           SizedBox(height: 20),

//           // Team Details
//           buildTeamSection(),

//           SizedBox(height: 20),

//           // Match State and Score
//           buildMatchStateAndScoreSection(),

//           SizedBox(height: 20),

//           // Player Goals
//           buildPlayerGoalsSection(),

//           SizedBox(height: 20),

//           // Team Analysis
//           buildAnalysisSection(),
//         ],
//       ),
//     );
//   }

//   Widget buildMatchInfoSection() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Champion: Premier League',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text('Round: Final'),
//             Text('Date: 12 Sept 2024'),
//             Text('Time: 18:00'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTeamSection() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Column(
//               children: [
//                 Image.network('https://media.gemini.media/img/yallakora/IOSTeams//120//2018/7/26/Malawi2018_7_26_19_24.jpg',
//                     width: 50, height: 30),
//                 Text('Team A'),
//               ],
//             ),
//             Text('VS',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             Column(
//               children: [
//                 Image.network('https://media.gemini.media/img/yallakora/IOSTeams//120//2018/7/26/Burundi2018_7_26_19_27.jpg',
//                     width: 50, height: 30),
//                 Text('Team B'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildMatchStateAndScoreSection() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text('Match State: Ongoing',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text('Score: 2 - 1',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildPlayerGoalsSection() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Player Goals',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text('Team A - Player 1: Goal at 15\''),
//             Text('Team A - Player 2: Goal at 45\''),
//             Text('Team B - Player 1: Goal at 60\''),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildAnalysisSection() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Team Analysis',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             buildAnalysisRow('Goals', '2', '1'),
//             buildAnalysisRow('Corners', '5', '3'),
//             buildAnalysisRow('Yellow Cards', '1', '2'),
//             buildAnalysisRow('Red Cards', '0', '1'),
//             buildAnalysisRow('Offside', '2', '1'),
//             buildAnalysisRow('Fouls', '10', '8'),
//             buildAnalysisRow('Shots on Goal', '7', '5'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildAnalysisRow(String stat, String teamAValue, String teamBValue) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(stat),
//         Text(teamAValue),
//         Text(teamBValue),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class MatchDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Set height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff2412C0),
                Color(0xff4910BC)
              ], // Define your gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor:
                Colors.transparent, // Set AppBar background to transparent
            elevation: 0,
            title: Text(
              'تفاصيل الخبر',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[200], // Light background color for header
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  Text('Le Parc De Princes', style: TextStyle(fontSize: 16)),
                  Text('1/8 Final',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Text('14.02.2023 00:00',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image.network(
                            "https://i.bleacherreport.net/images/team_logos/328x328/paris_saint_germain_fc.png?canvas=492,328",
                            width: 60,
                            height: 60,
                          ),
                          Text('Paris SG', style: TextStyle(fontSize: 16)),
                          Text('Home', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Text(
                        '2 : 3',
                        style:
                            TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/FC_Bayern_M%C3%BCnchen_logo_%282017%29.svg/1200px-FC_Bayern_M%C3%BCnchen_logo_%282017%29.svg.png',
                            width: 60,
                            height: 60,
                          ),
                          Text('FC Bayern', style: TextStyle(fontSize: 16)),
                          Text('Away', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('\'جاريه',
                      style: TextStyle(color: Colors.green, fontSize: 16)),
                ],
              ),
            ),
            SizedBox(height: 8),
            Column(
              children: [
                Text("إحصائيات المباراه",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                buildStatsTab(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildStatRow('الضربات الركنية', '7', '6'),
          buildStatRow('التسلل', '5', '2'),
          buildStatRow('التسديد على المرمى', '23', '23'),
          buildStatRow('الكروت الصفراء', '14', '9'),
          buildStatRow('الكروت الحمراء', '0', '0'),
        ],
      ),
    );
  }

  Widget buildStatRow(String stat, String teamAValue, String teamBValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(stat, style: TextStyle(fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(teamAValue, style: TextStyle(fontSize: 16)),
              SizedBox(width: 10),
              Container(
                width: 150,
                height: 10,
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor:
                          double.parse(teamAValue.replaceAll('%', '')) / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue, // Bar color for team A
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Text(teamBValue, style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
