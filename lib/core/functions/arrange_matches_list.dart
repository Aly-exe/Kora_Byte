void arrangeMatchesList(List matchesList){
      
      List<String> Egyptionteams = ['مصر', 'الأهلي', 'الزمالك'];
      List<String> seconedTeamsPriority = [
        'ريال مدريد',
        'برشلونة',
        'اتلتيكو مدريد',
        'آرسنال',
        'مانشستر سيتي',
        'ليفربول',
        'تشيلسي',
        'مانشستر يونايتد'
      ];
      List<String> priorityTeams = [
        'أستون فيلا',
        'نيوكاسل',
        'توتنهام',
        'بورنموث',
        'برينتفورد',
        'برايتون'
            'كريستال بالاس',
        'إيفرتون',
        'فولهام',
        'لوتون تاون',
        'نوتينغهام فورست',
        'شيفيلد يونايتد',
        'وست هام',
        'وولفز',
        'النصر',
        'الاتحاد',
        'الهلال',
        'أهلي جدة',
        'الريان',
        'الإسماعيلي',
        'غزل المحله',
        'الاتحاد السكندري',
        'بيراميدز'
      ];
      List<String> highestPriorityStates = [
        'استراحة',
        'الشوط الثاني',
        'الشوط الأول'
      ];
      matchesList.sort((a, b) {
        // Determine priority based on match state
        int aPriority = highestPriorityStates.indexOf(a.matchState);
        int bPriority = highestPriorityStates.indexOf(b.matchState);

        if (aPriority != -1 && bPriority == -1) {
          return -1; // Move a before b if a has higher priority state
        } else if (aPriority == -1 && bPriority != -1) {
          return 1; // Move b before a if b has higher priority state
        }
        // Check if either team is in the priority list
        bool aIsPriorityeg = Egyptionteams.contains(a.homeTeam) ||
            Egyptionteams.contains(a.awayTeam);
        bool bIsPriorityeg = Egyptionteams.contains(b.homeTeam) ||
            Egyptionteams.contains(b.awayTeam);

        if (aIsPriorityeg && !bIsPriorityeg) {
          return -1; // Move a before b if a is a priority team
        } else if (!aIsPriorityeg && bIsPriorityeg) {
          return 1; // Move b before a if b is a priority team
        }
        bool aIsPrioritySpEn = seconedTeamsPriority.contains(a.homeTeam) ||
            seconedTeamsPriority.contains(a.awayTeam);
        bool bIsPrioritySpEn = seconedTeamsPriority.contains(b.homeTeam) ||
            seconedTeamsPriority.contains(b.awayTeam);

        if (aIsPrioritySpEn && !bIsPrioritySpEn) {
          return -1; // Move a before b if a is a priority team
        } else if (!aIsPrioritySpEn && bIsPrioritySpEn) {
          return 1; // Move b before a if b is a priority team
        }

        bool aIsPriority = priorityTeams.contains(a.homeTeam) ||
            priorityTeams.contains(a.awayTeam);
        bool bIsPriority = priorityTeams.contains(b.homeTeam) ||
            priorityTeams.contains(b.awayTeam);

        if (aIsPriority && !bIsPriority) {
          return -1; // Move a before b if a is a priority team
        } else if (!aIsPriority && bIsPriority) {
          return 1; // Move b before a if b is a priority team
        }

        // Parse matchTime strings to DateTime objects for comparison
        DateTime aTime = DateTime.parse("1970-01-01 ${a.matchTime}:00");
        DateTime bTime = DateTime.parse("1970-01-01 ${b.matchTime}:00");

        if (a.matchState == "انتهت" && b.matchState != "انتهت") {
          return 1; // Move a after b if a is "انتهت"
        } else if (a.matchState != "انتهت" && b.matchState == "انتهت") {
          return -1; // Move b after a if b is "انتهت"
        }

        // If all matches have the state "انتهت", sort by team names
        if (a.matchState == "انتهت" && b.matchState == "انتهت") {
          int teamComparison = a.homeTeam.compareTo(b.homeTeam);
          if (teamComparison == 0) {
            teamComparison = a.awayTeam.compareTo(b.awayTeam);
          }
          return teamComparison;
        }

        // Compare by time if neither match state is "انتهت"
        return aTime.compareTo(bTime);
      });
}
