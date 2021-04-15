import 'package:project/widgets/chat/message_bubble.dart';

import 'model/message.dart';
import 'model/task.dart';
import 'model/project.dart';

const longDescription =
    'Human resources (HR) is the division of a business that is charged with finding, screening, recruiting, and training job applicants, as well as administering employee-benefit programs. HR plays a key role in helping companies deal with a fast-changing business environment and a greater demand for quality employees in the 21st century.,';

const List<User> users = [
  User(
      name: 'Mostafa Osama Hamed',
      id: 0,
      jobTitle: 'Flutter Developer',
      userName: '@Mostafa99'),
  User(
      name: 'Youssef Essam Name',
      id: 1,
      jobTitle: 'Java Developer',
      userName: '@Youssef_12'),
  User(
      name: 'Mohammed Hesham Name',
      id: 2,
      jobTitle: 'Flutter Developer',
      userName: '@MohammedH65'),
];

const List<User> usersLong = [
  User(
      id: 0,
      name: 'Mostafa Osama Hamed',
      jobTitle: 'Flutter Developer',
      userName: '@Mostafa99'),
  User(
      id: 1,
      name: 'Youssef Essam Name',
      jobTitle: 'Java Developer',
      userName: '@Youssef_12'),
  User(id: 2, name: 'Mohammed Hesham Name', jobTitle: 'Flutter Developer', userName: '@MohammedH65'),
  User(id: 3, name: 'Mostafa Osama Hamed', jobTitle: 'Flutter Developer', userName: '@Mostafa99'),
  User(id: 4, name: 'Youssef Essam Name', jobTitle: 'Java Developer', userName: '@Youssef_12'),
  User(id: 5, name: 'Mohammed Hesham Name', jobTitle: 'Flutter Developer', userName: '@MohammedH65'),
  User(id: 6, name: 'Mostafa Osama Hamed', jobTitle: 'Flutter Developer', userName: '@Mostafa99'),
  User(id: 7, name: 'Youssef Essam Name', jobTitle: 'Java Developer', userName: '@Youssef_12'),
  User(id: 8, name: 'Mohammed Hesham Name', jobTitle: 'Flutter Developer', userName: '@MohammedH65'),
  User(id: 9, name: 'Mostafa Osama Hamed', jobTitle: 'Flutter Developer', userName: '@Mostafa99'),
  User(id: 10, name: 'Youssef Essam Name', jobTitle: 'Java Developer', userName: '@Youssef_12'),
  User(id: 11, name: 'Mohammed Hesham Name', jobTitle: 'Flutter Developer', userName: '@MohammedH65')
];

List<Message> messagesList = [
  Message(
      dateTime: DateTime.now().subtract(Duration(hours: 12)),
      isMe: true,
      message: "Hello",
      senderName: "test"),
  Message(
      dateTime: DateTime.now().subtract(Duration(hours: 6)),
      isMe: false,
      message:
          "How are you ?,How are you ?How are you ?How are you ?How are you ?How are you ?How are you ?How are you ?How are you ?How are you ?How are you ?How are you ?",
      senderName: "test"),
  Message(
      dateTime: DateTime.now().subtract(Duration(minutes: 22)),
      isMe: true,
      message: "fine, thanks",
      senderName: "test"),
  Message(
      dateTime: DateTime.now(),
      isMe: false,
      message: "your progress is amazing this week",
      senderName: "test"),
  Message(
      dateTime: DateTime.now(),
      isMe: false,
      message: "your progress ",
      senderName: "test"),
  Message(
      dateTime: DateTime.now(),
      isMe: true,
      message: "i do my best",
      senderName: "test"),
  Message(
      dateTime: DateTime.now(),
      isMe: true,
      message:
          "i do my best, i do my best, i do my best, i do my best, i do my best, i do my best, i do my best, i do my best, i do my best, i do my best, i do my best, i do my best, i do my best, ",
      senderName: "test"),
];
final List<Team> teams = [
  Team(id: 0, name: 'Marketing', tasks: demoTasks),
  Team(id: 1, name: 'Public Relations', tasks: [
    Task(
        id: '0',
        name: 'planning publicity strategies',
        datePlannedStart: DateTime(2020, 12, 1),
        datePlannedEnd: DateTime(2021, 1, 25),
        description: 'Create Marketing strategy for new year',
        progress: 80,
        projectName: 'HR  ',
        checkPoints: const [
          CheckPoint(
              id: 0,
              name: 'strategy plan for first week',
              isFinished: false,
              description: 'in this week we would create strategy plan to achieve our strategy goal'),
          CheckPoint(
              id: 1,
              name: 'assign task for marketing team',
              isFinished: false,
              percentage: 10,
              description: "marketing team should be working on our plan ")
        ],
        //members:users ,
        assignedTeam: team,
        taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
    Task(
        id: '1',
        name: 'producing presentations',
        datePlannedStart: DateTime(2020, 12, 1),
        datePlannedEnd: DateTime(2021, 1, 25),
        description: 'Create Marketing strategy for new year',
        progress: 10,
        projectName: 'Hr  ',
        checkPoints: const [
          CheckPoint(
              id: 0,
              name: 'strategy plan for first week',
              isFinished: false,
              description: 'in this week we would create strategy plan to achieve our strategy goal'),
          CheckPoint(
              id: 1,
              name: 'assign task for marketing team',
              isFinished: false,
              percentage: 10,
              description: "marketing team should be working on our plan ")
        ],
        //members:users ,
        assignedTeam: team,
        taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
    Task(
        id: '2',
        name: 'dealing with enquiries',
        datePlannedStart: DateTime(2020, 12, 1),
        datePlannedEnd: DateTime(2021, 1, 25),
        description: 'Create Marketing strategy for new year',
        progress: 60,
        projectName: 'Hr  ',
        checkPoints: const [
          CheckPoint(
              id: 0,
              name: 'strategy plan for first week',
              isFinished: false,
              description: 'in this week we would create strategy plan to achieve our strategy goal'),
          CheckPoint(
              id: 1,
              name: 'assign task for marketing team',
              isFinished: false,
              percentage: 10,
              description: "marketing team should be working on our plan ")
        ],
        //members:users ,
        assignedTeam: team,
        taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
    Task(
        id: '3',
        name: 'analysing media coverage',
        datePlannedStart: DateTime(2020, 12, 1),
        datePlannedEnd: DateTime(2021, 1, 25),
        description: 'Create Marketing strategy for new year',
        progress: 20,
        projectName: 'Hr  ',
        checkPoints: const [
          CheckPoint(
              id: 0,
              name: 'strategy plan for first week',
              isFinished: true,
              description: 'in this week we would create strategy plan to achieve our strategy goal'),
          CheckPoint(
              id: 1,
              name: 'assign task for marketing team',
              isFinished: false,
              percentage: 10,
              description: "marketing team should be working on our plan ")
        ],
        //members:users ,
        assignedTeam: team,
        taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
  ]),
  Team(id: 2, name: 'Development', tasks: [
    Task(
        id: '0',
        name: 'Develop a website',
        datePlannedStart: DateTime(2020, 12, 1),
        datePlannedEnd: DateTime(2021, 1, 25),
        description: 'Create Marketing strategy for new year',
        progress: 80,
        projectName: 'Hr  ',
        checkPoints: const [
          CheckPoint(
              id: 0,
              name: 'strategy plan for first week',
              isFinished: false,
              description: 'in this week we would create strategy plan to achieve our strategy goal'),
          CheckPoint(
              id: 1,
              name: 'assign task for marketing team',
              isFinished: false,
              percentage: 10,
              description: "marketing team should be working on our plan ")
        ],
        //members:users ,
        assignedTeam: team,
        taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
    Task(
        id: '1',
        name: 'maintain database',
        datePlannedStart: DateTime(2020, 12, 1),
        datePlannedEnd: DateTime(2021, 1, 25),
        description: 'Create Marketing strategy for new year',
        progress: 30,
        projectName: 'Hr  ',
        checkPoints: const [
          CheckPoint(
              id: 0,
              name: 'strategy plan for first week',
              isFinished: false,
              description: 'in this week we would create strategy plan to achieve our strategy goal'),
          CheckPoint(
              id: 1,
              name: 'assign task for marketing team',
              isFinished: false,
              percentage: 10,
              description: "marketing team should be working on our plan ")
        ],
        //members:users ,
        assignedTeam: team,
        taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
  ]),
  Team(id: 0, name: 'Security', tasks: [
    Task(
        id: '0',
        name: 'maintain server security',
        datePlannedStart: DateTime(2020, 12, 1),
        datePlannedEnd: DateTime(2021, 1, 25),
        description: 'Create Marketing strategy for new year',
        progress: 80,
        projectName: 'Hr  ',
        checkPoints: const [
          CheckPoint(
              id: 0,
              name: 'strategy plan for first week',
              isFinished: false,
              description: 'in this week we would create strategy plan to achieve our strategy goal'),
          CheckPoint(
              id: 1,
              name: 'assign task for marketing team',
              isFinished: false,
              percentage: 10,
              description: "marketing team should be working on our plan ")
        ],
        //members:users ,
        assignedTeam: team,
        taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
  ]),
];

Team team = Team(name: 'Marketing team', id: 0);

List<Task> demoTasks = [
  Task(
      id: '0',
      name: 'Marketing strategy',
      datePlannedStart: DateTime(2020, 12, 1),
      datePlannedEnd: DateTime(2021, 1, 25),
      description: 'Create Marketing strategy for new year',
      progress: 80,
      projectName: 'Hr  ',
      checkPoints: const [
        CheckPoint(
            id: 0,
            name: 'strategy plan for first week',
            isFinished: false,
            description: 'in this week we would create strategy plan to achieve our strategy goal'),
        CheckPoint(
            id: 1,
            name: 'assign task for marketing team',
            isFinished: false,
            percentage: 10,
            description: "marketing team should be working on our plan ")
      ],
      //members:users ,
      assignedTeam: team,
      taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
  Task(
      id: '1',
      name: 'Social media ',
      datePlannedStart: DateTime(2021, 1, 18),
      datePlannedEnd: DateTime(2021, 1, 24),
      description:
          "social media team is to grow the business by strategically creating content, ads, and engaging with the target audience on different social media platforms.",
      progress: 10,
      projectName: 'Hr',
      checkPoints: const [
        CheckPoint(
            id: 0,
            name: 'create facebook content',
            isFinished: false,
            description:
                'we need a strong content that attracts customer to our company '),
        CheckPoint(
            id: 1,
            name: 'create twitter content',
            isFinished: false,
            description: "create twitter content and maintain company goals")
      ],
      parentCheckpoint: CheckPoint(
          id: 0,
          name: 'strategy plan for first week',
          isFinished: false,
          description:
              'in this week we would create strategy plan to achieve our strategy goal'),
      taskCreator: User(
          userName: '@UserName',
          jobTitle: 'job title',
          id: 1,
          name: 'Mostafa osama'),
      members: users),
  Task(
      id: '2',
      name: 'Search Engine',
      datePlannedStart: DateTime(2021, 8, 21),
      datePlannedEnd: DateTime(2021, 9, 5),
      description:
          'Search engine marketing, or SEM, is one of the most effective ways to grow your business in an increasingly competitive marketplace. With millions of businesses out there all vying for the same eyeballs, it’s never been more important to advertise online, and search engine marketing is the most effective way to promote your products and grow your business.',
      progress: 95,
      checkPoints: const [
        CheckPoint(
            id: 0,
            name: 'assign task to engineers',
            isFinished: false,
            description: 'we should achieve our search within a week'),
        CheckPoint(id: 1, name: 'achieve plans goal', description: 'good luck', isFinished: false)
      ],
      members: users,
      dependentTask: Task(
          id: '0',
          name: 'Marketing strategy',
          datePlannedStart: DateTime(2020, 12, 1),
          datePlannedEnd: DateTime(2021, 1, 25),
          description: 'Create Marketing strategy for new year',
          progress: 80,
          projectName: 'Hr  ',
          checkPoints: const [
            CheckPoint(
                id: 0,
                name: 'strategy plan for first week',
                isFinished: false,
                description: 'in this week we would create strategy plan to achieve our strategy goal'),
            CheckPoint(
                id: 1,
                name: 'assign task for marketing team',
                isFinished: false,
                percentage: 10,
                description: "marketing team should be working on our plan ")
          ],
          //members:users ,
          assignedTeam: team,
          taskCreator: User(
              userName: '@UserName',
              jobTitle: 'job title',
              id: 1,
              name: 'Mostafa Osama')),
      taskCreator: User(
          userName: '@UserName',
          jobTitle: 'job title',
          id: 1,
          name: 'Mostafa Osama')),
  Task(
      id: '4',
      name: 'Search Engine',
      datePlannedStart: DateTime(2021, 8, 21),
      datePlannedEnd: DateTime(2021, 9, 5),
      description:
          'Search engine marketing, or SEM, is one of the most effective ways to grow your business in an increasingly competitive marketplace. With millions of businesses out there all vying for the same eyeballs, it’s never been more important to advertise online, and search engine marketing is the most effective way to promote your products and grow your business.',
      progress: 95,
      checkPoints: const [
        CheckPoint(
            id: 0,
            name: 'assign task to engineers',
            isFinished: false,
            description: 'we should achieve our search within a week'),
        CheckPoint(
            id: 1,
            name: 'achieve plans goal',
            description: 'good luck',
            isFinished: false)
      ],
      members: users,
      dependentTask: Task(
          id: '0',
          name: 'Marketing strategy',
          datePlannedStart: DateTime(2020, 12, 1),
          datePlannedEnd: DateTime(2021, 1, 25),
          description: 'Create Marketing strategy for new year',
          progress: 80,
          projectName: 'Hr  ',
          checkPoints: const [
            CheckPoint(
                id: 0,
                name: 'strategy plan for first week',
                isFinished: false,
                description:
                    'in this week we would create strategy plan to achieve our strategy goal'),
            CheckPoint(
                id: 1,
                name: 'assign task for marketing team',
                isFinished: false,
                percentage: 10,
                description: "marketing team should be working on our plan ")
          ],
          //members:users ,
          assignedTeam: team,
          taskCreator: User(
              userName: '@UserName',
              jobTitle: 'job title',
              id: 1,
              name: 'Mostafa Osama')),
      taskCreator: User(
          userName: '@UserName',
          jobTitle: 'job title',
          id: 1,
          name: 'Mostafa Osama')),

//  Task( id: '2', name: 'create front-end',datePlannedStart: DateTime(2020,12,1) , datePlannedEnd: DateTime(2021,1,15),description: 'create app UI', progress: 20.0, projectName: 'work platform', checkPoints: const [ CheckPoint( id: '0', name: 'room screen', value: false, description: 'description of room screen'), CheckPoint(id: 0 name: 'team screen', value: false, percentage: 10)],
];

List<Teams> myTeams = [
  Teams(
      tasks: demoTasks,
      teamName: "Marketing",
      leaderName: "Mostafa",
      description:
          "The Marketing Department plays a vital role in promoting the business and mission of an organization. It serves as the face of your company, coordinating and producing all materials representing the business. It is the Marketing Department's job to reach out to prospects, customers, investors and/or the community, while creating an overarching image that represents your company in a positive light."),
  Teams(tasks: [
    Task(
        id: '0',
        name: 'Create front-end long name',
        datePlannedStart: DateTime(2020, 12, 1),
        datePlannedEnd: DateTime(2021, 1, 25),
        description: 'create app UI',
        progress: 20,
        projectName: 'work platform',
        checkPoints: const [
          CheckPoint(id: 0, name: 'room screen', isFinished: false, description: 'description of room screen'),
          CheckPoint(id: 1, name: 'team screen', isFinished: false, percentage: 10)
        ],
        members: users,
        taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
  ], teamName: "Public Relations", leaderName: "Ahmed", description: "this is ui team description "),
  Teams(tasks: [
    Task(
        id: '0',
        name: 'Create front-end long name',
        datePlannedStart: DateTime(2020, 12, 1),
        datePlannedEnd: DateTime(2021, 1, 25),
        description: 'create app UI',
        progress: 20,
        projectName: 'work platform',
        checkPoints: const [
          CheckPoint(id: 0, name: 'room screen', isFinished: false, description: 'description of room screen'),
          CheckPoint(id: 1, name: 'team screen', isFinished: false, percentage: 10)
        ],
        members: users,
        taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
    Task(
        id: '1',
        name: 'Create team screen',
        datePlannedStart: DateTime(2021, 1, 18),
        datePlannedEnd: DateTime(2021, 1, 24),
        description: '',
        progress: 10,
        projectName: 'work platform',
        checkPoints: const [
          CheckPoint(id: 0, name: 'task model', isFinished: false, description: 'finish task data model'),
          CheckPoint(id: 1, name: 're-design task widget', isFinished: false)
        ],
        parentCheckpoint: CheckPoint(id: 0, name: 'team screen', isFinished: false, percentage: 10),
        members: users),
    Task(
        id: '2',
        name: 'Dependent Task',
        datePlannedStart: DateTime(2021, 1, 24),
        datePlannedEnd: DateTime(2021, 2, 5),
        description: '',
        progress: 10,
        checkPoints: const [
          CheckPoint(id: 0, name: 'task model', isFinished: false, description: 'finish task data model'),
          CheckPoint(id: 1, name: 're-design task widget', isFinished: false)
        ],
        parentCheckpoint: CheckPoint(id: 0, name: 'team screen', isFinished: false, percentage: 10),
        members: users,
        dependentTask: Task(
          id: 'null',
          datePlannedEnd: DateTime(2021, 8, 21),
          name: 'Define team dataModel',
        ))
  ], teamName: "Development ", leaderName: "kamel", description: "this is flutter team description ")
];
List<Project> project = [
  Project(
      projectName: "Hr Company",
      startDate: DateTime(2020, 12, 1),
      endDate: DateTime(2021, 1, 18),
      mangerName: "Mostafa osama",
      description: longDescription,
      teams: [
        Teams(
            tasks: demoTasks,
            teamName: "Marketing strategy",
            leaderName: "Mostafa osama",
            description:
                "social media team is to grow the business by strategically creating content, ads, and engaging with the target audience on different social media platforms. "),
        Teams(
            tasks: demoTasks,
            teamName: "Social media marketing",
            leaderName: "Hesham",
            description:
                "social media team is to grow the business by strategically creating content, ads, and engaging with the target audience on different social media platforms.")
      ]),
  Project(
      projectName: "SoftWare Engineering",
      startDate: DateTime(2020, 12, 1),
      endDate: DateTime(2021, 1, 18),
      mangerName: "Hesham",
      description: "this is test description 2 wer are testing this application ",
      teams: [
        Teams(tasks: [
          Task(
              id: '0',
              name: 'Create front-end long name',
              datePlannedStart: DateTime(2020, 12, 1),
              datePlannedEnd: DateTime(2021, 1, 25),
              description: 'create app UI',
              progress: 20,
              projectName: 'work platform',
              checkPoints: const [
                CheckPoint(id: 0, name: 'room screen', isFinished: false, description: 'description of room screen'),
                CheckPoint(id: 01, name: 'team screen', isFinished: false, percentage: 10)
              ],
              members: users,
              taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Mostafa Osama')),
        ], teamName: "Developer Design", leaderName: "Magda", description: longDescription),
        Teams(
            tasks: [
              Task(
                  id: '0',
                  name: 'Create SmartHome',
                  datePlannedStart: DateTime(2020, 12, 1),
                  datePlannedEnd: DateTime(2021, 1, 25),
                  description: 'create UI Home',
                  progress: 20,
                  projectName: 'Home Home',
                  checkPoints: const [
                    CheckPoint(
                        id: 0, name: 'Home screen', isFinished: false, description: 'description of Home screen'),
                    CheckPoint(id: 01, name: 'team screen', isFinished: false, percentage: 15)
                  ],
                  members: users,
                  taskCreator: User(userName: '@UserName', jobTitle: 'job title', id: 1, name: 'Hesham')),
              Task(
                  id: '1',
                  name: 'screen',
                  datePlannedStart: DateTime(2021, 1, 14),
                  datePlannedEnd: DateTime(2021, 1, 24),
                  description: '',
                  progress: 15,
                  projectName: 'flutter',
                  checkPoints: const [
                    CheckPoint(
                        id: 0, name: 'flutter model', isFinished: false, description: 'finish flutter data model'),
                    CheckPoint(id: 01, name: 're-design task widget', isFinished: false)
                  ],
                  parentCheckpoint: CheckPoint(id: 0, name: 'team screen', isFinished: false, percentage: 10),
                  members: users),
            ],
            teamName: "Apis migrate",
            leaderName: "momen",
            description:
                "Human resources (HR) is the division of a business that is charged with finding, screening, recruiting, and training job applicants, as well as administering employee-benefit programs. HR plays a key role in helping companies deal with a fast-changing business environment and a greater demand for quality employees in the 21st century. example of a long an example of a long description to test the three line in description text form field ")
      ])
];

// List<Teams> teams = [
//   Teams(
//     tasks: [],
//     teamName: "UI/UX Design",
//     leaderName: "Ahmed",
//     description:
//         longDescription,
//   ),
//   Teams(
//       teamName: "Developing chat app",
//       leaderName: "Kamal",
//       description:
//           longDescription)
// ];
