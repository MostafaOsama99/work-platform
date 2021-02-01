import 'model/task.dart';
import 'model/project.dart';

const longDescription =
    'this an example of a long description to test the three line in description text form field this an example of a long description to test the three line in description text form field this an example of a long description to test the three line in description text form field this an example of a long description to test the three line in description text form field';

List<Task> demoTasks = [
  Task(
      id: '0',
      name: 'Create front-end long name',
      datePlannedStart: DateTime(2020, 12, 1),
      datePlannedEnd: DateTime(2021, 1, 25),
      description: 'create app UI',
      progress: 20.0,
      projectName: 'work platform',
      checkPoints: const [
        CheckPoint(
            id: '0',
            name: 'room screen',
            value: false,
            description: 'description of room screen'),
        CheckPoint(id: '1', name: 'team screen', value: false, percentage: 10)
      ],
      members: const ['mostafa osama', 'mohammed hesham'],
      taskCreator: 'Mostafa Osama'),
  Task(
      id: '1',
      name: 'Create team screen',
      datePlannedStart: DateTime(2021, 1, 18),
      datePlannedEnd: DateTime(2021, 1, 24),
      description: longDescription,
      progress: 10.0,
      projectName: 'work platform',
      checkPoints: const [
        CheckPoint(
            id: '0',
            name: 'task model',
            value: false,
            description: 'finish task data model'),
        CheckPoint(id: '1', name: 're-design task widget', value: false)
      ],
      parentCheckpoint: CheckPoint(
        id: '1',
        name: 'team screen',
        value: false,
        percentage: 10,
        description: longDescription,
      ),
      members: ['mostafa osama']),
  Task(
      id: '2',
      name: 'Dependent Task',
      datePlannedStart: DateTime(2021, 1, 24),
      datePlannedEnd: DateTime(2021, 2, 5),
      description: longDescription,
      progress: 10.0,
      checkPoints: const [
        CheckPoint(
            id: '0',
            name: 'task model',
            value: false,
            description: 'finish task data model'),
        CheckPoint(id: '1', name: 're-design task widget', value: false)
      ],
      parentCheckpoint: CheckPoint(
          id: '1',
          name: 'team screen',
          value: false,
          percentage: 10,
          description: longDescription),
      members: ['mostafa osama'],
      dependentTask: Task(
        id: 'null',
        datePlannedEnd: DateTime(2021, 8, 21),
        name: 'Define team dataModel',
        description: longDescription,
      )),
//  Task( id: '2', name: 'create front-end',datePlannedStart: DateTime(2020,12,1) , datePlannedEnd: DateTime(2021,1,15),description: 'create app UI', progress: 20.0, projectName: 'work platform', checkPoints: const [ CheckPoint( id: '0', name: 'room screen', value: false, description: 'description of room screen'), CheckPoint(id: '1', name: 'team screen', value: false, percentage: 10)] ),
];

List<Teams> myTeams = [
  Teams(
      tasks: [
        Task(
            id: '0',
            name: 'Create front-end long name',
            datePlannedStart: DateTime(2020, 12, 1),
            datePlannedEnd: DateTime(2021, 1, 25),
            description: 'create app UI',
            progress: 20.0,
            projectName: 'work platform',
            checkPoints: const [
              CheckPoint(
                  id: '0',
                  name: 'room screen',
                  value: false,
                  description: 'description of room screen'),
              CheckPoint(
                  id: '1', name: 'team screen', value: false, percentage: 10)
            ],
            members: const ['mostafa osama', 'mohammed hesham'],
            taskCreator: 'Mostafa Osama'),
      ],
      teamName: "UI/UX Design",
      leaderName: "Ahmed",
      description: "this is ui team description "),
  Teams(
      tasks: [
        Task(
            id: '0',
            name: 'Create front-end long name',
            datePlannedStart: DateTime(2020, 12, 1),
            datePlannedEnd: DateTime(2021, 1, 25),
            description: 'create app UI',
            progress: 20.0,
            projectName: 'work platform',
            checkPoints: const [
              CheckPoint(
                  id: '0',
                  name: 'room screen',
                  value: false,
                  description: 'description of room screen'),
              CheckPoint(
                  id: '1', name: 'team screen', value: false, percentage: 10)
            ],
            members: const ['mostafa osama', 'mohammed hesham'],
            taskCreator: 'Mostafa Osama'),
        Task(
            id: '1',
            name: 'Create team screen',
            datePlannedStart: DateTime(2021, 1, 18),
            datePlannedEnd: DateTime(2021, 1, 24),
            description: '',
            progress: 10.0,
            projectName: 'work platform',
            checkPoints: const [
              CheckPoint(
                  id: '0',
                  name: 'task model',
                  value: false,
                  description: 'finish task data model'),
              CheckPoint(id: '1', name: 're-design task widget', value: false)
            ],
            parentCheckpoint: CheckPoint(
                id: '1', name: 'team screen', value: false, percentage: 10),
            members: ['mostafa osama']),
        Task(
            id: '2',
            name: 'Dependent Task',
            datePlannedStart: DateTime(2021, 1, 24),
            datePlannedEnd: DateTime(2021, 2, 5),
            description: '',
            progress: 10.0,
            checkPoints: const [
              CheckPoint(
                  id: '0',
                  name: 'task model',
                  value: false,
                  description: 'finish task data model'),
              CheckPoint(id: '1', name: 're-design task widget', value: false)
            ],
            parentCheckpoint: CheckPoint(
                id: '1', name: 'team screen', value: false, percentage: 10),
            members: ['mostafa osama'],
            dependentTask: Task(
              id: 'null',
              datePlannedEnd: DateTime(2021, 8, 21),
              name: 'Define team dataModel',
            ))
      ],
      teamName: "flutter",
      leaderName: "kamel",
      description: "this is flutter team description ")
];
List<Project> project = [
  Project(
      projectName: "GP Discussion",
      startDate: DateTime(2020, 12, 1),
      endDate: DateTime(2021, 1, 18),
      mangerName: "Ahmed",
      description: longDescription,
      teams: [
        Teams(
            tasks: [
              Task(
                  id: '0',
                  name: 'Create front-end long name',
                  datePlannedStart: DateTime(2020, 12, 1),
                  datePlannedEnd: DateTime(2021, 1, 25),
                  description: 'create app UI',
                  progress: 20.0,
                  projectName: 'work platform',
                  checkPoints: const [
                    CheckPoint(
                        id: '0',
                        name: 'room screen',
                        value: false,
                        description: 'description of room screen'),
                    CheckPoint(
                        id: '1',
                        name: 'team screen',
                        value: false,
                        percentage: 10)
                  ],
                  members: const ['mostafa osama', 'mohammed hesham'],
                  taskCreator: 'Mostafa Osama'),
            ],
            teamName: "UI/UX Design",
            leaderName: "Ahmed",
            description: "this is ui team description "),
        Teams(
            tasks: [
              Task(
                  id: '0',
                  name: 'Create front-end long name',
                  datePlannedStart: DateTime(2020, 12, 1),
                  datePlannedEnd: DateTime(2021, 1, 25),
                  description: 'create app UI',
                  progress: 20.0,
                  projectName: 'work platform',
                  checkPoints: const [
                    CheckPoint(
                        id: '0',
                        name: 'room screen',
                        value: false,
                        description: 'description of room screen'),
                    CheckPoint(
                        id: '1',
                        name: 'team screen',
                        value: false,
                        percentage: 10)
                  ],
                  members: const ['mostafa osama', 'mohammed hesham'],
                  taskCreator: 'Mostafa Osama'),
              Task(
                  id: '1',
                  name: 'Create team screen',
                  datePlannedStart: DateTime(2021, 1, 18),
                  datePlannedEnd: DateTime(2021, 1, 24),
                  description: '',
                  progress: 10.0,
                  projectName: 'work platform',
                  checkPoints: const [
                    CheckPoint(
                        id: '0',
                        name: 'task model',
                        value: false,
                        description: 'finish task data model'),
                    CheckPoint(
                        id: '1', name: 're-design task widget', value: false)
                  ],
                  parentCheckpoint: CheckPoint(
                      id: '1',
                      name: 'team screen',
                      value: false,
                      percentage: 10,
                      description: longDescription),
                  members: ['mostafa osama']),
              Task(
                  id: '2',
                  name: 'Dependent Task',
                  datePlannedStart: DateTime(2021, 1, 24),
                  datePlannedEnd: DateTime(2021, 2, 5),
                  description: '',
                  progress: 10.0,
                  checkPoints: const [
                    CheckPoint(
                        id: '0',
                        name: 'task model',
                        value: false,
                        description: 'finish task data model'),
                    CheckPoint(
                        id: '1', name: 're-design task widget', value: false)
                  ],
                  parentCheckpoint: CheckPoint(
                      id: '1',
                      name: 'team screen',
                      value: false,
                      percentage: 10,
                      description: longDescription),
                  members: ['mostafa osama'],
                  dependentTask: Task(
                    id: 'null',
                    datePlannedEnd: DateTime(2021, 8, 21),
                    name: 'Define team dataModel',
                  ))
            ],
            teamName: "flutter",
            leaderName: "kamel",
            description: "this is flutter team description ")
      ]),
  Project(
      projectName: "SoftWare Engineering  ",
      startDate: DateTime(2020, 12, 1),
      endDate: DateTime(2021, 1, 18),
      mangerName: "Ibrahim",
      description:
          "this is test description 2 wer are testing this application ",
      teams: [
        Teams(
            tasks: [
              Task(
                  id: '0',
                  name: 'Create front-end long name',
                  datePlannedStart: DateTime(2020, 12, 1),
                  datePlannedEnd: DateTime(2021, 1, 25),
                  description: 'create app UI',
                  progress: 20.0,
                  projectName: 'work platform',
                  checkPoints: const [
                    CheckPoint(
                        id: '0',
                        name: 'room screen',
                        value: false,
                        description: 'description of room screen'),
                    CheckPoint(
                        id: '1',
                        name: 'team screen',
                        value: false,
                        percentage: 10)
                  ],
                  members: const ['mostafa osama', 'mohammed hesham'],
                  taskCreator: 'Mostafa Osama'),
            ],
            teamName: "Developer Design",
            leaderName: "Magda",
            description: longDescription),
        Teams(
            tasks: [
              Task(
                  id: '0',
                  name: 'Create SmartHome',
                  datePlannedStart: DateTime(2020, 12, 1),
                  datePlannedEnd: DateTime(2021, 1, 25),
                  description: 'create UI Home',
                  progress: 20.0,
                  projectName: 'Home Home',
                  checkPoints: const [
                    CheckPoint(
                        id: '0',
                        name: 'Home screen',
                        value: false,
                        description: 'description of Home screen'),
                    CheckPoint(
                        id: '1',
                        name: 'team screen',
                        value: false,
                        percentage: 15)
                  ],
                  members: const ['mohammed hesham', "yousef"],
                  taskCreator: 'Hesham'),
              Task(
                  id: '1',
                  name: 'screen',
                  datePlannedStart: DateTime(2021, 1, 14),
                  datePlannedEnd: DateTime(2021, 1, 24),
                  description: '',
                  progress: 15.0,
                  projectName: 'flutter',
                  checkPoints: const [
                    CheckPoint(
                        id: '0',
                        name: 'flutter model',
                        value: false,
                        description: 'finish flutter data model'),
                    CheckPoint(
                        id: '1', name: 're-design task widget', value: false)
                  ],
                  parentCheckpoint: CheckPoint(
                      id: '1',
                      name: 'team screen',
                      value: false,
                      percentage: 10),
                  members: ['mostafa osama']),
            ],
            teamName: "marwan",
            leaderName: "momen",
            description:
                "this an example of a long an example of a long description to test the three line in description text form field ")
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
