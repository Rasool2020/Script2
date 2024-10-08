Set IDENTITY_INSERT [t00RegionType] ON
Alter Table [t00RegionType] Disable Trigger All
if not Exists(Select * From t00RegionType Where id=4 )
INSERT INTO [t00RegionType]([id],[name],[parentID],[isFixed],[isActive],[code],[SuggestCodeLenght]) 
Values(4,'استان',Null,1,1,'1',2)
Go

if not Exists(Select * From t00RegionType Where id=5 )
INSERT INTO [t00RegionType]([id],[name],[parentID],[isFixed],[isActive],[code],[SuggestCodeLenght]) 
Values(5,'شهر',Null,1,1,'2',2)
Go
Set IDENTITY_INSERT [t00Region] ON
Alter Table [t00Region] Disable Trigger All
if not Exists(Select * From t00Region Where id=32 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(32,'گيلان',Null,4,'32',0)
Go

if not Exists(Select * From t00Region Where id=33 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(33,'مازندران',Null,4,'33',0)
Go

if not Exists(Select * From t00Region Where id=34 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(34,'گلستان',Null,4,'34',0)
Go

if not Exists(Select * From t00Region Where id=35 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(35,'تهران',Null,4,'35',0)
Go

if not Exists(Select * From t00Region Where id=36 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(36,'سمنان',Null,4,'36',0)
Go

if not Exists(Select * From t00Region Where id=37 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(37,'زنجان',Null,4,'37',0)
Go

if not Exists(Select * From t00Region Where id=38 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(38,'قم',Null,4,'38',0)
Go

if not Exists(Select * From t00Region Where id=39 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(39,'قزوين',Null,4,'39',0)
Go

if not Exists(Select * From t00Region Where id=40 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(40,'اصفهان',Null,4,'40',0)
Go

if not Exists(Select * From t00Region Where id=41 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(41,'كرمان',Null,4,'41',0)
Go

if not Exists(Select * From t00Region Where id=42 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(42,'يزد',Null,4,'42',0)
Go

if not Exists(Select * From t00Region Where id=43 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(43,'چهارمحال بختياري',Null,4,'43',0)
Go

if not Exists(Select * From t00Region Where id=44 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(44,'آذربايجان شرقي',Null,4,'44',0)
Go

if not Exists(Select * From t00Region Where id=45 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(45,'آذربايجان غربي',Null,4,'45',0)
Go

if not Exists(Select * From t00Region Where id=46 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(46,'اردبيل',Null,4,'46',0)
Go

if not Exists(Select * From t00Region Where id=47 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(47,'خراسان رضوي',Null,4,'47',0)
Go

if not Exists(Select * From t00Region Where id=48 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(48,'سيستان و بلوچستان',Null,4,'48',0)
Go

if not Exists(Select * From t00Region Where id=49 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(49,'خوزستان',Null,4,'49',0)
Go

if not Exists(Select * From t00Region Where id=50 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(50,'لرستان',Null,4,'50',0)
Go

if not Exists(Select * From t00Region Where id=51 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(51,'فارس',Null,4,'51',0)
Go

if not Exists(Select * From t00Region Where id=52 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(52,'كهكيلويه وبويراحمد',Null,4,'52',0)
Go

if not Exists(Select * From t00Region Where id=53 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(53,'هرمزگان',Null,4,'53',0)
Go

if not Exists(Select * From t00Region Where id=54 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(54,'بوشهر',Null,4,'54',0)
Go

if not Exists(Select * From t00Region Where id=55 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(55,'همدان',Null,4,'55',0)
Go

if not Exists(Select * From t00Region Where id=56 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(56,'كرمانشاه',Null,4,'56',0)
Go

if not Exists(Select * From t00Region Where id=57 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(57,'ايلام',Null,4,'57',0)
Go

if not Exists(Select * From t00Region Where id=58 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(58,'مركزي',Null,4,'58',0)
Go

if not Exists(Select * From t00Region Where id=59 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(59,'كردستان',Null,4,'59',0)
Go

if not Exists(Select * From t00Region Where id=60 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(60,'خراسان جنوبي',Null,4,'60',0)
Go

if not Exists(Select * From t00Region Where id=61 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(61,'خراسان شمالي',Null,4,'61',0)
Go

if not Exists(Select * From t00Region Where id=62 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(62,'البرز',Null,4,'62',0)
Go

if not Exists(Select * From t00Region Where id=63 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(63,'نامشخص',Null,4,'63',0)
Go

if not Exists(Select * From t00Region Where id=64 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(64,'كوچصفهان',32,5,'827',1)
Go

if not Exists(Select * From t00Region Where id=65 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(65,'كياشهر',32,5,'826',1)
Go

if not Exists(Select * From t00Region Where id=66 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(66,'كلاچاي',32,5,'387',1)
Go

if not Exists(Select * From t00Region Where id=67 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(67,'آستارا',32,5,'380',1)
Go

if not Exists(Select * From t00Region Where id=68 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(68,'آستانه اشرفيه',32,5,'382',1)
Go

if not Exists(Select * From t00Region Where id=69 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(69,'اسالم',32,5,'819',1)
Go

if not Exists(Select * From t00Region Where id=70 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(70,'املش',32,5,'654',1)
Go

if not Exists(Select * From t00Region Where id=71 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(71,'برهسر',32,5,'820',1)
Go

if not Exists(Select * From t00Region Where id=72 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(72,'بندرانزلي',32,5,'386',1)
Go

if not Exists(Select * From t00Region Where id=73 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(73,'توتكابن',32,5,'821',1)
Go

if not Exists(Select * From t00Region Where id=74 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(74,'چابكسر',32,5,'822',1)
Go

if not Exists(Select * From t00Region Where id=75 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(75,'خشك بيجار',32,5,'823',1)
Go

if not Exists(Select * From t00Region Where id=76 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(76,'خمام',32,5,'828',1)
Go

if not Exists(Select * From t00Region Where id=77 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(77,'ديلمان',32,5,'829',1)
Go

if not Exists(Select * From t00Region Where id=78 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(78,'رحيم آباد',32,5,'830',1)
Go

if not Exists(Select * From t00Region Where id=79 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(79,'رستم آباد',32,5,'1058',1)
Go

if not Exists(Select * From t00Region Where id=80 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(80,'رشت',32,5,'622',1)
Go

if not Exists(Select * From t00Region Where id=81 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(81,'رضوان شهر',32,5,'650',1)
Go

if not Exists(Select * From t00Region Where id=82 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(82,'رودبار',32,5,'383',1)
Go

if not Exists(Select * From t00Region Where id=83 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(83,'رودسر',32,5,'378',1)
Go

if not Exists(Select * From t00Region Where id=84 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(84,'سنگر',32,5,'832',1)
Go

if not Exists(Select * From t00Region Where id=85 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(85,'سياهكل',32,5,'653',1)
Go

if not Exists(Select * From t00Region Where id=86 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(86,'شفت',32,5,'652',1)
Go

if not Exists(Select * From t00Region Where id=87 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(87,'صومعه سرا',32,5,'385',1)
Go

if not Exists(Select * From t00Region Where id=88 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(88,'فومن',32,5,'384',1)
Go

if not Exists(Select * From t00Region Where id=89 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(89,'لاهيجان',32,5,'715',1)
Go

if not Exists(Select * From t00Region Where id=90 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(90,'لشت نشا',32,5,'824',1)
Go

if not Exists(Select * From t00Region Where id=91 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(91,'لنگرود',32,5,'377',1)
Go

if not Exists(Select * From t00Region Where id=92 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(92,'لوشان',32,5,'825',1)
Go

if not Exists(Select * From t00Region Where id=93 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(93,'ماسال',32,5,'651',1)
Go

if not Exists(Select * From t00Region Where id=94 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(94,'ماسوله',32,5,'381',1)
Go

if not Exists(Select * From t00Region Where id=95 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(95,'منجيل',32,5,'376',1)
Go

if not Exists(Select * From t00Region Where id=96 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(96,'هشتپر',32,5,'649',1)
Go

if not Exists(Select * From t00Region Where id=97 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(97,'نوشهر',33,5,'402',1)
Go

if not Exists(Select * From t00Region Where id=98 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(98,'نكاء',33,5,'399',1)
Go

if not Exists(Select * From t00Region Where id=99 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(99,'نشتارود',33,5,'818',1)
Go

if not Exists(Select * From t00Region Where id=100 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(100,'نور',33,5,'400',1)
Go

if not Exists(Select * From t00Region Where id=101 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(101,'محمودآباد',33,5,'656',1)
Go

if not Exists(Select * From t00Region Where id=102 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(102,'مرزن آباد',33,5,'817',1)
Go

if not Exists(Select * From t00Region Where id=103 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(103,'گلوگاه',33,5,'750',1)
Go

if not Exists(Select * From t00Region Where id=104 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(104,'قائم شهر',33,5,'398',1)
Go

if not Exists(Select * From t00Region Where id=105 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(105,'عباس آباد',33,5,'811',1)
Go

if not Exists(Select * From t00Region Where id=106 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(106,'فريدون كنار',33,5,'657',1)
Go

if not Exists(Select * From t00Region Where id=107 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(107,'سورك',33,5,'1027',1)
Go

if not Exists(Select * From t00Region Where id=108 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(108,'سلمانشهر',33,5,'810',1)
Go

if not Exists(Select * From t00Region Where id=109 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(109,'رويان',33,5,'809',1)
Go

if not Exists(Select * From t00Region Where id=110 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(110,'ساري',33,5,'388',1)
Go

if not Exists(Select * From t00Region Where id=111 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(111,'رامسر',33,5,'396',1)
Go

if not Exists(Select * From t00Region Where id=112 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(112,'خرم آباد',33,5,'808',1)
Go

if not Exists(Select * From t00Region Where id=113 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(113,'جويبار',33,5,'394',1)
Go

if not Exists(Select * From t00Region Where id=114 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(114,'چالوس',33,5,'395',1)
Go

if not Exists(Select * From t00Region Where id=115 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(115,'چمستان',33,5,'807',1)
Go

if not Exists(Select * From t00Region Where id=116 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(116,'پل سفيد',33,5,'397',1)
Go

if not Exists(Select * From t00Region Where id=117 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(117,'تنكابن',33,5,'393',1)
Go

if not Exists(Select * From t00Region Where id=118 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(118,'بهشهر',33,5,'392',1)
Go

if not Exists(Select * From t00Region Where id=119 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(119,'بلده',33,5,'401',1)
Go

if not Exists(Select * From t00Region Where id=120 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(120,'ايزدشهر',33,5,'814',1)
Go

if not Exists(Select * From t00Region Where id=121 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(121,'بابل',33,5,'390',1)
Go

if not Exists(Select * From t00Region Where id=122 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(122,'بابلسر',33,5,'391',1)
Go

if not Exists(Select * From t00Region Where id=123 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(123,'آلاشت',33,5,'813',1)
Go

if not Exists(Select * From t00Region Where id=124 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(124,'آمل',33,5,'389',1)
Go

if not Exists(Select * From t00Region Where id=125 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(125,'كلارآباد',33,5,'812',1)
Go

if not Exists(Select * From t00Region Where id=126 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(126,'كلاردشت',33,5,'815',1)
Go

if not Exists(Select * From t00Region Where id=127 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(127,'كياسر',33,5,'816',1)
Go

if not Exists(Select * From t00Region Where id=128 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(128,'كلاله',34,5,'411',1)
Go

if not Exists(Select * From t00Region Where id=129 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(129,'كردكوي',34,5,'409',1)
Go

if not Exists(Select * From t00Region Where id=130 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(130,'آق قلا',34,5,'404',1)
Go

if not Exists(Select * From t00Region Where id=131 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(131,'آزادشهر',34,5,'412',1)
Go

if not Exists(Select * From t00Region Where id=132 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(132,'اينچه برون',34,5,'882',1)
Go

if not Exists(Select * From t00Region Where id=133 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(133,'بندر گز',34,5,'410',1)
Go

if not Exists(Select * From t00Region Where id=134 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(134,'بندرتركمن',34,5,'408',1)
Go

if not Exists(Select * From t00Region Where id=135 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(135,'خان ببين',34,5,'883',1)
Go

if not Exists(Select * From t00Region Where id=136 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(136,'راميان',34,5,'658',1)
Go

if not Exists(Select * From t00Region Where id=137 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(137,'دلند',34,5,'884',1)
Go

if not Exists(Select * From t00Region Where id=138 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(138,'علي آباد',34,5,'406',1)
Go

if not Exists(Select * From t00Region Where id=139 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(139,'فاضل آباد',34,5,'1045',1)
Go

if not Exists(Select * From t00Region Where id=140 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(140,'سيمين شهر',34,5,'885',1)
Go

if not Exists(Select * From t00Region Where id=141 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(141,'گاليكش',34,5,'879',1)
Go

if not Exists(Select * From t00Region Where id=142 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(142,'گميش تپه',34,5,'880',1)
Go

if not Exists(Select * From t00Region Where id=143 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(143,'گنبدكاوس',34,5,'405',1)
Go

if not Exists(Select * From t00Region Where id=144 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(144,'گرگان',34,5,'403',1)
Go

if not Exists(Select * From t00Region Where id=145 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(145,'مراوه تپه',34,5,'881',1)
Go

if not Exists(Select * From t00Region Where id=146 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(146,'مينودشت',34,5,'407',1)
Go

if not Exists(Select * From t00Region Where id=147 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(147,'نوكنده',34,5,'1046',1)
Go

if not Exists(Select * From t00Region Where id=148 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(148,'ملارد',35,5,'670',1)
Go

if not Exists(Select * From t00Region Where id=149 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(149,'گلستان',35,5,'673',1)
Go

if not Exists(Select * From t00Region Where id=150 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(150,'لواسان',35,5,'660',1)
Go

if not Exists(Select * From t00Region Where id=151 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(151,'قرچك',35,5,'675',1)
Go

if not Exists(Select * From t00Region Where id=152 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(152,'فيروزكوه',35,5,'419',1)
Go

if not Exists(Select * From t00Region Where id=153 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(153,'شاهدشهر',35,5,'1001',1)
Go

if not Exists(Select * From t00Region Where id=154 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(154,'شهر قدس',35,5,'418',1)
Go

if not Exists(Select * From t00Region Where id=155 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(155,'شريف آباد',35,5,'674',1)
Go

if not Exists(Select * From t00Region Where id=156 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(156,'شهريار',35,5,'416',1)
Go

if not Exists(Select * From t00Region Where id=157 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(157,'فشم',35,5,'663',1)
Go

if not Exists(Select * From t00Region Where id=158 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(158,'صفادشت',35,5,'999',1)
Go

if not Exists(Select * From t00Region Where id=159 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(159,'ري',35,5,'420',1)
Go

if not Exists(Select * From t00Region Where id=160 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(160,'رودهن',35,5,'659',1)
Go

if not Exists(Select * From t00Region Where id=161 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(161,'دماوند',35,5,'421',1)
Go

if not Exists(Select * From t00Region Where id=162 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(162,'رباط كريم',35,5,'666',1)
Go

if not Exists(Select * From t00Region Where id=163 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(163,'حسن آباد',35,5,'1000',1)
Go

if not Exists(Select * From t00Region Where id=164 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(164,'خرمدشت',35,5,'995',1)
Go

if not Exists(Select * From t00Region Where id=165 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(165,'تهران',35,5,'413',1)
Go

if not Exists(Select * From t00Region Where id=166 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(166,'پيشوا',35,5,'993',1)
Go

if not Exists(Select * From t00Region Where id=167 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(167,'تجريش',35,5,'662',1)
Go

if not Exists(Select * From t00Region Where id=168 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(168,'پاكدشت',35,5,'665',1)
Go

if not Exists(Select * From t00Region Where id=169 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(169,'پرند',35,5,'1012',1)
Go

if not Exists(Select * From t00Region Where id=170 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(170,'بومهن',35,5,'661',1)
Go

if not Exists(Select * From t00Region Where id=171 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(171,'چهاردانگه',35,5,'672',1)
Go

if not Exists(Select * From t00Region Where id=172 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(172,'جاجرود',35,5,'994',1)
Go

if not Exists(Select * From t00Region Where id=173 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(173,'باقر شهر',35,5,'996',1)
Go

if not Exists(Select * From t00Region Where id=174 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(174,'آبسرد',35,5,'1002',1)
Go

if not Exists(Select * From t00Region Where id=175 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(175,'آبعلي',35,5,'998',1)
Go

if not Exists(Select * From t00Region Where id=176 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(176,'انديشه',35,5,'1008',1)
Go

if not Exists(Select * From t00Region Where id=177 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(177,'اسلام شهر',35,5,'422',1)
Go

if not Exists(Select * From t00Region Where id=178 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(178,'ورامين',35,5,'417',1)
Go

if not Exists(Select * From t00Region Where id=179 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(179,'كهريزك',35,5,'664',1)
Go

if not Exists(Select * From t00Region Where id=180 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(180,'ارادان',36,5,'924',1)
Go

if not Exists(Select * From t00Region Where id=181 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(181,'ايوانكي',36,5,'427',1)
Go

if not Exists(Select * From t00Region Where id=182 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(182,'بسطام',36,5,'677',1)
Go

if not Exists(Select * From t00Region Where id=183 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(183,'دامغان',36,5,'676',1)
Go

if not Exists(Select * From t00Region Where id=184 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(184,'سمنان',36,5,'424',1)
Go

if not Exists(Select * From t00Region Where id=185 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(185,'سرخه',36,5,'920',1)
Go

if not Exists(Select * From t00Region Where id=186 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(186,'شهميرزاد',36,5,'922',1)
Go

if not Exists(Select * From t00Region Where id=187 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(187,'شاهرود',36,5,'425',1)
Go

if not Exists(Select * From t00Region Where id=188 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(188,'گرمسار',36,5,'426',1)
Go

if not Exists(Select * From t00Region Where id=189 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(189,'مهدي شهر',36,5,'921',1)
Go

if not Exists(Select * From t00Region Where id=190 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(190,'ميامي',36,5,'923',1)
Go

if not Exists(Select * From t00Region Where id=191 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(191,'گرماب',37,5,'984',1)
Go

if not Exists(Select * From t00Region Where id=192 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(192,'گيلوان',37,5,'987',1)
Go

if not Exists(Select * From t00Region Where id=193 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(193,'ماهنشان',37,5,'432',1)
Go

if not Exists(Select * From t00Region Where id=194 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(194,'قيدار',37,5,'680',1)
Go

if not Exists(Select * From t00Region Where id=195 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(195,'سهرورد',37,5,'932',1)
Go

if not Exists(Select * From t00Region Where id=196 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(196,'صائين قلعه',37,5,'980',1)
Go

if not Exists(Select * From t00Region Where id=197 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(197,'سجاس',37,5,'986',1)
Go

if not Exists(Select * From t00Region Where id=198 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(198,'سلطانيه',37,5,'982',1)
Go

if not Exists(Select * From t00Region Where id=199 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(199,'زنجان',37,5,'428',1)
Go

if not Exists(Select * From t00Region Where id=200 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(200,'زرين آباد',37,5,'678',1)
Go

if not Exists(Select * From t00Region Where id=201 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(201,'زرين رود',37,5,'985',1)
Go

if not Exists(Select * From t00Region Where id=202 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(202,'خرمدره',37,5,'433',1)
Go

if not Exists(Select * From t00Region Where id=203 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(203,'حلب',37,5,'990',1)
Go

if not Exists(Select * From t00Region Where id=204 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(204,'دندي',37,5,'988',1)
Go

if not Exists(Select * From t00Region Where id=205 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(205,'ايجرود',37,5,'434',1)
Go

if not Exists(Select * From t00Region Where id=206 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(206,'ابهر',37,5,'429',1)
Go

if not Exists(Select * From t00Region Where id=207 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(207,'آب بر',37,5,'679',1)
Go

if not Exists(Select * From t00Region Where id=208 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(208,'هيدج',37,5,'981',1)
Go

if not Exists(Select * From t00Region Where id=209 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(209,'كهك',38,5,'890',1)
Go

if not Exists(Select * From t00Region Where id=210 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(210,'دستجرد',38,5,'887',1)
Go

if not Exists(Select * From t00Region Where id=211 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(211,'جعفريه',38,5,'886',1)
Go

if not Exists(Select * From t00Region Where id=212 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(212,'سلفچگان',38,5,'888',1)
Go

if not Exists(Select * From t00Region Where id=213 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(213,'قم',38,5,'435',1)
Go

if not Exists(Select * From t00Region Where id=214 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(214,'قنوات',38,5,'889',1)
Go

if not Exists(Select * From t00Region Where id=215 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(215,'قزوين',39,5,'436',1)
Go

if not Exists(Select * From t00Region Where id=216 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(216,'ضياآباد',39,5,'915',1)
Go

if not Exists(Select * From t00Region Where id=217 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(217,'تاكستان',39,5,'437',1)
Go

if not Exists(Select * From t00Region Where id=218 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(218,'خرمدشت',39,5,'919',1)
Go

if not Exists(Select * From t00Region Where id=219 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(219,'آبگرم',39,5,'918',1)
Go

if not Exists(Select * From t00Region Where id=220 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(220,'آبيك',39,5,'629',1)
Go

if not Exists(Select * From t00Region Where id=221 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(221,'آوج',39,5,'1036',1)
Go

if not Exists(Select * From t00Region Where id=222 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(222,'اقباليه',39,5,'916',1)
Go

if not Exists(Select * From t00Region Where id=223 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(223,'الوند',39,5,'917',1)
Go

if not Exists(Select * From t00Region Where id=224 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(224,'بوئين زهرا',39,5,'681',1)
Go

if not Exists(Select * From t00Region Where id=225 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(225,'بهارستان',40,5,'752',1)
Go

if not Exists(Select * From t00Region Where id=226 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(226,'بادرود',40,5,'770',1)
Go

if not Exists(Select * From t00Region Where id=227 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(227,'باغ بهادران',40,5,'448',1)
Go

if not Exists(Select * From t00Region Where id=228 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(228,'برخوار و ميمه',40,5,'521',1)
Go

if not Exists(Select * From t00Region Where id=229 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(229,'اصفهان',40,5,'438',1)
Go

if not Exists(Select * From t00Region Where id=230 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(230,'آران وبيدگل',40,5,'447',1)
Go

if not Exists(Select * From t00Region Where id=231 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(231,'اردستان',40,5,'626',1)
Go

if not Exists(Select * From t00Region Where id=232 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(232,'داران',40,5,'768',1)
Go

if not Exists(Select * From t00Region Where id=233 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(233,'خميني شهر',40,5,'442',1)
Go

if not Exists(Select * From t00Region Where id=234 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(234,'خوانسار',40,5,'623',1)
Go

if not Exists(Select * From t00Region Where id=235 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(235,'خور',40,5,'1031',1)
Go

if not Exists(Select * From t00Region Where id=236 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(236,'خورزوق',40,5,'1052',1)
Go

if not Exists(Select * From t00Region Where id=237 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(237,'دهاقان',40,5,'783',1)
Go

if not Exists(Select * From t00Region Where id=238 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(238,'درچه پياز',40,5,'766',1)
Go

if not Exists(Select * From t00Region Where id=239 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(239,'دولت آباد',40,5,'445',1)
Go

if not Exists(Select * From t00Region Where id=240 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(240,'جوزدان',40,5,'767',1)
Go

if not Exists(Select * From t00Region Where id=241 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(241,'جوشقان و كامو',40,5,'786',1)
Go

if not Exists(Select * From t00Region Where id=242 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(242,'تيران',40,5,'620',1)
Go

if not Exists(Select * From t00Region Where id=243 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(243,'چادگان',40,5,'771',1)
Go

if not Exists(Select * From t00Region Where id=244 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(244,'فلاورجان',40,5,'615',1)
Go

if not Exists(Select * From t00Region Where id=245 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(245,'فريدن',40,5,'613',1)
Go

if not Exists(Select * From t00Region Where id=246 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(246,'فريدون شهر',40,5,'614',1)
Go

if not Exists(Select * From t00Region Where id=247 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(247,'شاهين شهر',40,5,'443',1)
Go

if not Exists(Select * From t00Region Where id=248 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(248,'شهرضا',40,5,'441',1)
Go

if not Exists(Select * From t00Region Where id=249 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(249,'سميرم',40,5,'617',1)
Go

if not Exists(Select * From t00Region Where id=250 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(250,'سده لنجان',40,5,'765',1)
Go

if not Exists(Select * From t00Region Where id=251 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(251,'زرين شهر',40,5,'446',1)
Go

if not Exists(Select * From t00Region Where id=252 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(252,'زاينده رود',40,5,'787',1)
Go

if not Exists(Select * From t00Region Where id=253 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(253,'زيبا شهر',40,5,'782',1)
Go

if not Exists(Select * From t00Region Where id=254 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(254,'رضوان شهر',40,5,'788',1)
Go

if not Exists(Select * From t00Region Where id=255 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(255,'فولادشهر',40,5,'621',1)
Go

if not Exists(Select * From t00Region Where id=256 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(256,'قهجاورستان',40,5,'1038',1)
Go

if not Exists(Select * From t00Region Where id=257 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(257,'قهد ريجان',40,5,'784',1)
Go

if not Exists(Select * From t00Region Where id=258 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(258,'قمصر',40,5,'785',1)
Go

if not Exists(Select * From t00Region Where id=259 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(259,'گرگاب',40,5,'1057',1)
Go

if not Exists(Select * From t00Region Where id=260 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(260,'مباركه',40,5,'440',1)
Go

if not Exists(Select * From t00Region Where id=261 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(261,'نائين',40,5,'619',1)
Go

if not Exists(Select * From t00Region Where id=262 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(262,'نجف آباد',40,5,'444',1)
Go

if not Exists(Select * From t00Region Where id=263 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(263,'گلپايگان',40,5,'616',1)
Go

if not Exists(Select * From t00Region Where id=264 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(264,'نطنز',40,5,'618',1)
Go

if not Exists(Select * From t00Region Where id=265 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(265,'كهريزسنگ',40,5,'1035',1)
Go

if not Exists(Select * From t00Region Where id=266 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(266,'ورزنه',40,5,'1037',1)
Go

if not Exists(Select * From t00Region Where id=267 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(267,'كاشان',40,5,'439',1)
Go

if not Exists(Select * From t00Region Where id=268 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(268,'كوشك',40,5,'753',1)
Go

if not Exists(Select * From t00Region Where id=269 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(269,'كوهپايه',40,5,'769',1)
Go

if not Exists(Select * From t00Region Where id=270 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(270,'كوهبنان',41,5,'862',1)
Go

if not Exists(Select * From t00Region Where id=271 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(271,'يزدانشهر',41,5,'870',1)
Go

if not Exists(Select * From t00Region Where id=272 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(272,'كرمان',41,5,'449',1)
Go

if not Exists(Select * From t00Region Where id=273 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(273,'كهنوج',41,5,'455',1)
Go

if not Exists(Select * From t00Region Where id=274 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(274,'نودژ',41,5,'868',1)
Go

if not Exists(Select * From t00Region Where id=275 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(275,'هجدك',41,5,'869',1)
Go

if not Exists(Select * From t00Region Where id=276 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(276,'نجف شهر',41,5,'867',1)
Go

if not Exists(Select * From t00Region Where id=277 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(277,'منوجان',41,5,'866',1)
Go

if not Exists(Select * From t00Region Where id=278 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(278,'محمد آباد',41,5,'864',1)
Go

if not Exists(Select * From t00Region Where id=279 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(279,'ماهان',41,5,'1019',1)
Go

if not Exists(Select * From t00Region Where id=280 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(280,'قلعه گنج',41,5,'861',1)
Go

if not Exists(Select * From t00Region Where id=281 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(281,'فهرج',41,5,'1056',1)
Go

if not Exists(Select * From t00Region Where id=282 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(282,'رفسنجان',41,5,'452',1)
Go

if not Exists(Select * From t00Region Where id=283 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(283,'رودبار',41,5,'859',1)
Go

if not Exists(Select * From t00Region Where id=284 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(284,'زرند',41,5,'456',1)
Go

if not Exists(Select * From t00Region Where id=285 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(285,'سرچشمه',41,5,'865',1)
Go

if not Exists(Select * From t00Region Where id=286 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(286,'شهربابك',41,5,'451',1)
Go

if not Exists(Select * From t00Region Where id=287 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(287,'سيرجان',41,5,'454',1)
Go

if not Exists(Select * From t00Region Where id=288 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(288,'عنبرآباد',41,5,'860',1)
Go

if not Exists(Select * From t00Region Where id=289 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(289,'جيرفت',41,5,'458',1)
Go

if not Exists(Select * From t00Region Where id=290 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(290,'چترود',41,5,'1043',1)
Go

if not Exists(Select * From t00Region Where id=291 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(291,'بهرمان',41,5,'858',1)
Go

if not Exists(Select * From t00Region Where id=292 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(292,'راور',41,5,'450',1)
Go

if not Exists(Select * From t00Region Where id=293 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(293,'اختيارآباد',41,5,'856',1)
Go

if not Exists(Select * From t00Region Where id=294 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(294,'ارزوئيه',41,5,'1010',1)
Go

if not Exists(Select * From t00Region Where id=295 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(295,'بردسير',41,5,'1017',1)
Go

if not Exists(Select * From t00Region Where id=296 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(296,'بافت',41,5,'453',1)
Go

if not Exists(Select * From t00Region Where id=297 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(297,'انار',41,5,'857',1)
Go

if not Exists(Select * From t00Region Where id=298 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(298,'بم',41,5,'457',1)
Go

if not Exists(Select * From t00Region Where id=299 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(299,'بهاباد',42,5,'1051',1)
Go

if not Exists(Select * From t00Region Where id=300 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(300,'بافق',42,5,'683',1)
Go

if not Exists(Select * From t00Region Where id=301 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(301,'اردكان',42,5,'462',1)
Go

if not Exists(Select * From t00Region Where id=302 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(302,'ابركوه',42,5,'463',1)
Go

if not Exists(Select * From t00Region Where id=303 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(303,'خاتم',42,5,'754',1)
Go

if not Exists(Select * From t00Region Where id=304 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(304,'تفت',42,5,'461',1)
Go

if not Exists(Select * From t00Region Where id=305 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(305,'فهرج',42,5,'1044',1)
Go

if not Exists(Select * From t00Region Where id=306 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(306,'زارچ',42,5,'1050',1)
Go

if not Exists(Select * From t00Region Where id=307 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(307,'مهريز',42,5,'684',1)
Go

if not Exists(Select * From t00Region Where id=308 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(308,'ميبد',42,5,'464',1)
Go

if not Exists(Select * From t00Region Where id=309 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(309,'مروست',42,5,'755',1)
Go

if not Exists(Select * From t00Region Where id=310 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(310,'هرات',42,5,'686',1)
Go

if not Exists(Select * From t00Region Where id=311 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(311,'ندوشن',42,5,'876',1)
Go

if not Exists(Select * From t00Region Where id=312 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(312,'يزد',42,5,'460',1)
Go

if not Exists(Select * From t00Region Where id=313 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(313,'كوهرنگ',43,5,'761',1)
Go

if not Exists(Select * From t00Region Where id=314 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(314,'لردگان',43,5,'699',1)
Go

if not Exists(Select * From t00Region Where id=315 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(315,'سامان',43,5,'700',1)
Go

if not Exists(Select * From t00Region Where id=316 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(316,'فارسان',43,5,'466',1)
Go

if not Exists(Select * From t00Region Where id=317 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(317,'فرخ شهر',43,5,'763',1)
Go

if not Exists(Select * From t00Region Where id=318 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(318,'شلمزار',43,5,'758',1)
Go

if not Exists(Select * From t00Region Where id=319 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(319,'شهركرد',43,5,'465',1)
Go

if not Exists(Select * From t00Region Where id=320 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(320,'بلداجي',43,5,'759',1)
Go

if not Exists(Select * From t00Region Where id=321 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(321,'چلگرد',43,5,'697',1)
Go

if not Exists(Select * From t00Region Where id=322 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(322,'جونقان',43,5,'764',1)
Go

if not Exists(Select * From t00Region Where id=323 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(323,'اردل',43,5,'698',1)
Go

if not Exists(Select * From t00Region Where id=324 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(324,'بن',43,5,'1040',1)
Go

if not Exists(Select * From t00Region Where id=325 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(325,'بروجن',43,5,'624',1)
Go

if not Exists(Select * From t00Region Where id=326 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(326,'بستان آباد',44,5,'701',1)
Go

if not Exists(Select * From t00Region Where id=327 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(327,'بناب',44,5,'477',1)
Go

if not Exists(Select * From t00Region Where id=328 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(328,'آذر شهر',44,5,'704',1)
Go

if not Exists(Select * From t00Region Where id=329 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(329,'اسكو',44,5,'703',1)
Go

if not Exists(Select * From t00Region Where id=330 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(330,'اهر',44,5,'480',1)
Go

if not Exists(Select * From t00Region Where id=331 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(331,'جلفا',44,5,'474',1)
Go

if not Exists(Select * From t00Region Where id=332 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(332,'تبريز',44,5,'467',1)
Go

if not Exists(Select * From t00Region Where id=333 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(333,'تركمانچاي',44,5,'843',1)
Go

if not Exists(Select * From t00Region Where id=334 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(334,'تسوج',44,5,'479',1)
Go

if not Exists(Select * From t00Region Where id=335 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(335,'خامنه',44,5,'847',1)
Go

if not Exists(Select * From t00Region Where id=336 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(336,'خسروشهر',44,5,'1053',1)
Go

if not Exists(Select * From t00Region Where id=337 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(337,'شبستر',44,5,'472',1)
Go

if not Exists(Select * From t00Region Where id=338 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(338,'شرفخانه',44,5,'469',1)
Go

if not Exists(Select * From t00Region Where id=339 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(339,'صوفيان',44,5,'848',1)
Go

if not Exists(Select * From t00Region Where id=340 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(340,'عجب شير',44,5,'482',1)
Go

if not Exists(Select * From t00Region Where id=341 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(341,'سراب',44,5,'475',1)
Go

if not Exists(Select * From t00Region Where id=342 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(342,'قره آغاج',44,5,'705',1)
Go

if not Exists(Select * From t00Region Where id=343 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(343,'ميانه',44,5,'471',1)
Go

if not Exists(Select * From t00Region Where id=344 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(344,'نظركهريزي',44,5,'844',1)
Go

if not Exists(Select * From t00Region Where id=345 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(345,'هشترود',44,5,'483',1)
Go

if not Exists(Select * From t00Region Where id=346 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(346,'هاديشهر',44,5,'476',1)
Go

if not Exists(Select * From t00Region Where id=347 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(347,'هريس',44,5,'481',1)
Go

if not Exists(Select * From t00Region Where id=348 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(348,'مرند',44,5,'473',1)
Go

if not Exists(Select * From t00Region Where id=349 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(349,'مراغه',44,5,'470',1)
Go

if not Exists(Select * From t00Region Where id=350 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(350,'ممقان',44,5,'845',1)
Go

if not Exists(Select * From t00Region Where id=351 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(351,'ملكان',44,5,'484',1)
Go

if not Exists(Select * From t00Region Where id=352 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(352,'كندوان',44,5,'468',1)
Go

if not Exists(Select * From t00Region Where id=353 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(353,'كليبر',44,5,'478',1)
Go

if not Exists(Select * From t00Region Where id=354 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(354,'ورزقان',44,5,'702',1)
Go

if not Exists(Select * From t00Region Where id=355 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(355,'هوراند',44,5,'846',1)
Go

if not Exists(Select * From t00Region Where id=356 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(356,'مهاباد',45,5,'490',1)
Go

if not Exists(Select * From t00Region Where id=357 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(357,'مياندوآب',45,5,'494',1)
Go

if not Exists(Select * From t00Region Where id=358 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(358,'نقده',45,5,'486',1)
Go

if not Exists(Select * From t00Region Where id=359 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(359,'قره ضياءالدين',45,5,'780',1)
Go

if not Exists(Select * From t00Region Where id=360 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(360,'قوشچي',45,5,'849',1)
Go

if not Exists(Select * From t00Region Where id=361 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(361,'ماكو',45,5,'487',1)
Go

if not Exists(Select * From t00Region Where id=362 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(362,'سردشت',45,5,'491',1)
Go

if not Exists(Select * From t00Region Where id=363 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(363,'سلماس',45,5,'495',1)
Go

if not Exists(Select * From t00Region Where id=364 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(364,'شوط',45,5,'779',1)
Go

if not Exists(Select * From t00Region Where id=365 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(365,'شاهين دژ',45,5,'630',1)
Go

if not Exists(Select * From t00Region Where id=366 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(366,'سيه چشمه',45,5,'707',1)
Go

if not Exists(Select * From t00Region Where id=367 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(367,'خوي',45,5,'489',1)
Go

if not Exists(Select * From t00Region Where id=368 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(368,'پلدشت',45,5,'781',1)
Go

if not Exists(Select * From t00Region Where id=369 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(369,'پيرانشهر',45,5,'706',1)
Go

if not Exists(Select * From t00Region Where id=370 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(370,'بوكان',45,5,'493',1)
Go

if not Exists(Select * From t00Region Where id=371 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(371,'تكاب',45,5,'488',1)
Go

if not Exists(Select * From t00Region Where id=372 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(372,'اشنويه',45,5,'708',1)
Go

if not Exists(Select * From t00Region Where id=373 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(373,'اروميه',45,5,'485',1)
Go

if not Exists(Select * From t00Region Where id=374 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(374,'بازرگان',45,5,'850',1)
Go

if not Exists(Select * From t00Region Where id=375 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(375,'اصلاندوز',46,5,'931',1)
Go

if not Exists(Select * From t00Region Where id=376 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(376,'اردبيل',46,5,'496',1)
Go

if not Exists(Select * From t00Region Where id=377 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(377,'بيله سوار',46,5,'498',1)
Go

if not Exists(Select * From t00Region Where id=378 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(378,'پارس آباد',46,5,'499',1)
Go

if not Exists(Select * From t00Region Where id=379 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(379,'خلخال',46,5,'500',1)
Go

if not Exists(Select * From t00Region Where id=380 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(380,'سرعين',46,5,'497',1)
Go

if not Exists(Select * From t00Region Where id=381 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(381,'رضي',46,5,'930',1)
Go

if not Exists(Select * From t00Region Where id=382 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(382,'گرمي',46,5,'710',1)
Go

if not Exists(Select * From t00Region Where id=383 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(383,'نمين',46,5,'503',1)
Go

if not Exists(Select * From t00Region Where id=384 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(384,'نير',46,5,'504',1)
Go

if not Exists(Select * From t00Region Where id=385 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(385,'مشگين شهر',46,5,'501',1)
Go

if not Exists(Select * From t00Region Where id=386 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(386,'كيوي',46,5,'709',1)
Go

if not Exists(Select * From t00Region Where id=387 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(387,'كاشمر',47,5,'510',1)
Go

if not Exists(Select * From t00Region Where id=388 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(388,'كلات',47,5,'718',1)
Go

if not Exists(Select * From t00Region Where id=389 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(389,'مشهد',47,5,'506',1)
Go

if not Exists(Select * From t00Region Where id=390 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(390,'ملك آباد',47,5,'841',1)
Go

if not Exists(Select * From t00Region Where id=391 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(391,'نيشابور',47,5,'507',1)
Go

if not Exists(Select * From t00Region Where id=392 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(392,'نصرآباد',47,5,'834',1)
Go

if not Exists(Select * From t00Region Where id=393 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(393,'گلبهار',47,5,'1054',1)
Go

if not Exists(Select * From t00Region Where id=394 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(394,'گناباد',47,5,'511',1)
Go

if not Exists(Select * From t00Region Where id=395 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(395,'قوچان',47,5,'519',1)
Go

if not Exists(Select * From t00Region Where id=396 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(396,'فيض آباد',47,5,'835',1)
Go

if not Exists(Select * From t00Region Where id=397 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(397,'فيروزه',47,5,'836',1)
Go

if not Exists(Select * From t00Region Where id=398 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(398,'رضويه',47,5,'842',1)
Go

if not Exists(Select * From t00Region Where id=399 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(399,'رشتخوار',47,5,'838',1)
Go

if not Exists(Select * From t00Region Where id=400 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(400,'سبزوار',47,5,'508',1)
Go

if not Exists(Select * From t00Region Where id=401 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(401,'سرخس',47,5,'522',1)
Go

if not Exists(Select * From t00Region Where id=402 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(402,'شانديز',47,5,'837',1)
Go

if not Exists(Select * From t00Region Where id=403 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(403,'طرقبه',47,5,'719',1)
Go

if not Exists(Select * From t00Region Where id=404 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(404,'صالح آباد',47,5,'833',1)
Go

if not Exists(Select * From t00Region Where id=405 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(405,'فريمان',47,5,'713',1)
Go

if not Exists(Select * From t00Region Where id=406 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(406,'خليل آباد',47,5,'839',1)
Go

if not Exists(Select * From t00Region Where id=407 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(407,'خواف',47,5,'516',1)
Go

if not Exists(Select * From t00Region Where id=408 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(408,'داورزن',47,5,'1011',1)
Go

if not Exists(Select * From t00Region Where id=409 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(409,'درگز',47,5,'716',1)
Go

if not Exists(Select * From t00Region Where id=410 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(410,'تايباد',47,5,'518',1)
Go

if not Exists(Select * From t00Region Where id=411 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(411,'تربت جام',47,5,'517',1)
Go

if not Exists(Select * From t00Region Where id=412 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(412,'تربت حيدريه',47,5,'515',1)
Go

if not Exists(Select * From t00Region Where id=413 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(413,'چناران',47,5,'714',1)
Go

if not Exists(Select * From t00Region Where id=414 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(414,'بجستان',47,5,'840',1)
Go

if not Exists(Select * From t00Region Where id=415 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(415,'بردسكن',47,5,'712',1)
Go

if not Exists(Select * From t00Region Where id=416 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(416,'ايرانشهر',48,5,'530',1)
Go

if not Exists(Select * From t00Region Where id=417 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(417,'چابهار',48,5,'524',1)
Go

if not Exists(Select * From t00Region Where id=418 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(418,'خاش',48,5,'525',1)
Go

if not Exists(Select * From t00Region Where id=419 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(419,'فنوج',48,5,'1030',1)
Go

if not Exists(Select * From t00Region Where id=420 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(420,'سوران',48,5,'893',1)
Go

if not Exists(Select * From t00Region Where id=421 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(421,'سرباز',48,5,'528',1)
Go

if not Exists(Select * From t00Region Where id=422 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(422,'سراوان',48,5,'526',1)
Go

if not Exists(Select * From t00Region Where id=423 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(423,'زهك',48,5,'891',1)
Go

if not Exists(Select * From t00Region Where id=424 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(424,'زابل',48,5,'527',1)
Go

if not Exists(Select * From t00Region Where id=425 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(425,'زاهدان',48,5,'523',1)
Go

if not Exists(Select * From t00Region Where id=426 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(426,'قصرقند',48,5,'1032',1)
Go

if not Exists(Select * From t00Region Where id=427 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(427,'نصرت آباد',48,5,'892',1)
Go

if not Exists(Select * From t00Region Where id=428 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(428,'نيك شهر',48,5,'529',1)
Go

if not Exists(Select * From t00Region Where id=429 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(429,'ميرجاوه',48,5,'632',1)
Go

if not Exists(Select * From t00Region Where id=430 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(430,'كنارك',48,5,'894',1)
Go

if not Exists(Select * From t00Region Where id=431 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(431,'هيرمند',48,5,'1034',1)
Go

if not Exists(Select * From t00Region Where id=432 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(432,'هويزه',49,5,'638',1)
Go

if not Exists(Select * From t00Region Where id=433 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(433,'مسجد سليمان',49,5,'633',1)
Go

if not Exists(Select * From t00Region Where id=434 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(434,'هنديجان',49,5,'647',1)
Go

if not Exists(Select * From t00Region Where id=435 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(435,'هفتگل',49,5,'778',1)
Go

if not Exists(Select * From t00Region Where id=436 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(436,'مينوشهر',49,5,'805',1)
Go

if not Exists(Select * From t00Region Where id=437 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(437,'قلعه خواجه',49,5,'803',1)
Go

if not Exists(Select * From t00Region Where id=438 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(438,'گتوند',49,5,'801',1)
Go

if not Exists(Select * From t00Region Where id=439 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(439,'لالي',49,5,'648',1)
Go

if not Exists(Select * From t00Region Where id=440 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(440,'ماهشهر',49,5,'641',1)
Go

if not Exists(Select * From t00Region Where id=441 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(441,'سوسنگرد',49,5,'637',1)
Go

if not Exists(Select * From t00Region Where id=442 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(442,'شادگان',49,5,'640',1)
Go

if not Exists(Select * From t00Region Where id=443 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(443,'شوش',49,5,'533',1)
Go

if not Exists(Select * From t00Region Where id=444 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(444,'شوشتر',49,5,'635',1)
Go

if not Exists(Select * From t00Region Where id=445 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(445,'خرمشهر',49,5,'535',1)
Go

if not Exists(Select * From t00Region Where id=446 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(446,'دزفول',49,5,'639',1)
Go

if not Exists(Select * From t00Region Where id=447 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(447,'رامشير',49,5,'520',1)
Go

if not Exists(Select * From t00Region Where id=448 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(448,'رامهرمز',49,5,'645',1)
Go

if not Exists(Select * From t00Region Where id=449 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(449,'چمران',49,5,'804',1)
Go

if not Exists(Select * From t00Region Where id=450 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(450,'ايذه',49,5,'634',1)
Go

if not Exists(Select * From t00Region Where id=451 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(451,'اهواز',49,5,'531',1)
Go

if not Exists(Select * From t00Region Where id=452 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(452,'باغ ملك',49,5,'646',1)
Go

if not Exists(Select * From t00Region Where id=453 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(453,'بندرامام خميني ',49,5,'642',1)
Go

if not Exists(Select * From t00Region Where id=454 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(454,'بستان',49,5,'806',1)
Go

if not Exists(Select * From t00Region Where id=455 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(455,'بهبهان',49,5,'644',1)
Go

if not Exists(Select * From t00Region Where id=456 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(456,'آغاجاري',49,5,'802',1)
Go

if not Exists(Select * From t00Region Where id=457 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(457,'آبادان',49,5,'534',1)
Go

if not Exists(Select * From t00Region Where id=458 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(458,'انديمشك',49,5,'636',1)
Go

if not Exists(Select * From t00Region Where id=459 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(459,'اميديه',49,5,'643',1)
Go

if not Exists(Select * From t00Region Where id=460 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(460,'اليگودرز',50,5,'539',1)
Go

if not Exists(Select * From t00Region Where id=461 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(461,'الشتر',50,5,'543',1)
Go

if not Exists(Select * From t00Region Where id=462 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(462,'ازنا',50,5,'540',1)
Go

if not Exists(Select * From t00Region Where id=463 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(463,'اشترينان',50,5,'905',1)
Go

if not Exists(Select * From t00Region Where id=464 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(464,'بروجرد',50,5,'537',1)
Go

if not Exists(Select * From t00Region Where id=465 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(465,'چالان چولان',50,5,'906',1)
Go

if not Exists(Select * From t00Region Where id=466 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(466,'چغلوندي',50,5,'907',1)
Go

if not Exists(Select * From t00Region Where id=467 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(467,'پل دختر',50,5,'544',1)
Go

if not Exists(Select * From t00Region Where id=468 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(468,'دورود',50,5,'538',1)
Go

if not Exists(Select * From t00Region Where id=469 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(469,'خرم آباد',50,5,'536',1)
Go

if not Exists(Select * From t00Region Where id=470 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(470,'سراب دوره',50,5,'910',1)
Go

if not Exists(Select * From t00Region Where id=471 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(471,'سپيددشت',50,5,'909',1)
Go

if not Exists(Select * From t00Region Where id=472 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(472,'زاغه',50,5,'908',1)
Go

if not Exists(Select * From t00Region Where id=473 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(473,'فيروزآباد',50,5,'912',1)
Go

if not Exists(Select * From t00Region Where id=474 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(474,'نور آباد',50,5,'541',1)
Go

if not Exists(Select * From t00Region Where id=475 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(475,'معمولان',50,5,'913',1)
Go

if not Exists(Select * From t00Region Where id=476 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(476,'كوهدشت',50,5,'542',1)
Go

if not Exists(Select * From t00Region Where id=477 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(477,'كازرون',51,5,'552',1)
Go

if not Exists(Select * From t00Region Where id=478 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(478,'كوار',51,5,'1021',1)
Go

if not Exists(Select * From t00Region Where id=479 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(479,'مصيري-رستم',51,5,'1023',1)
Go

if not Exists(Select * From t00Region Where id=480 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(480,'مرودشت',51,5,'549',1)
Go

if not Exists(Select * From t00Region Where id=481 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(481,'ممسني',51,5,'553',1)
Go

if not Exists(Select * From t00Region Where id=482 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(482,'مهر',51,5,'688',1)
Go

if not Exists(Select * From t00Region Where id=483 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(483,'نورآباد',51,5,'690',1)
Go

if not Exists(Select * From t00Region Where id=484 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(484,'ني ريز',51,5,'558',1)
Go

if not Exists(Select * From t00Region Where id=485 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(485,'فيروزآباد',51,5,'556',1)
Go

if not Exists(Select * From t00Region Where id=486 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(486,'گراش',51,5,'792',1)
Go

if not Exists(Select * From t00Region Where id=487 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(487,'قيروكارزين',51,5,'694',1)
Go

if not Exists(Select * From t00Region Where id=488 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(488,'لامرد',51,5,'687',1)
Go

if not Exists(Select * From t00Region Where id=489 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(489,'لار',51,5,'555',1)
Go

if not Exists(Select * From t00Region Where id=490 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(490,'لارستان',51,5,'749',1)
Go

if not Exists(Select * From t00Region Where id=491 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(491,'گله دار',51,5,'1042',1)
Go

if not Exists(Select * From t00Region Where id=492 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(492,'زرقان',51,5,'1041',1)
Go

if not Exists(Select * From t00Region Where id=493 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(493,'سپيدان',51,5,'554',1)
Go

if not Exists(Select * From t00Region Where id=494 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(494,'سروستان',51,5,'796',1)
Go

if not Exists(Select * From t00Region Where id=495 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(495,'سعادت شهر',51,5,'797',1)
Go

if not Exists(Select * From t00Region Where id=496 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(496,'سيدان',51,5,'798',1)
Go

if not Exists(Select * From t00Region Where id=497 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(497,'فراشبند',51,5,'696',1)
Go

if not Exists(Select * From t00Region Where id=498 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(498,'فسا',51,5,'548',1)
Go

if not Exists(Select * From t00Region Where id=499 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(499,'صفاشهر',51,5,'692',1)
Go

if not Exists(Select * From t00Region Where id=500 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(500,'شيراز',51,5,'545',1)
Go

if not Exists(Select * From t00Region Where id=501 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(501,'خرامه',51,5,'1022',1)
Go

if not Exists(Select * From t00Region Where id=502 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(502,'خرم بيد',51,5,'550',1)
Go

if not Exists(Select * From t00Region Where id=503 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(503,'داريان',51,5,'795',1)
Go

if not Exists(Select * From t00Region Where id=504 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(504,'داراب',51,5,'547',1)
Go

if not Exists(Select * From t00Region Where id=505 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(505,'خنج',51,5,'793',1)
Go

if not Exists(Select * From t00Region Where id=506 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(506,'حاجي آباد',51,5,'689',1)
Go

if not Exists(Select * From t00Region Where id=507 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(507,'جهرم',51,5,'557',1)
Go

if not Exists(Select * From t00Region Where id=508 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(508,'بصيري-رستم',51,5,'1024',1)
Go

if not Exists(Select * From t00Region Where id=509 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(509,'بوانات',51,5,'790',1)
Go

if not Exists(Select * From t00Region Where id=510 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(510,'اوز',51,5,'789',1)
Go

if not Exists(Select * From t00Region Where id=511 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(511,'اردكان',51,5,'691',1)
Go

if not Exists(Select * From t00Region Where id=512 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(512,'ارسنجان',51,5,'693',1)
Go

if not Exists(Select * From t00Region Where id=513 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(513,'استهبان',51,5,'559',1)
Go

if not Exists(Select * From t00Region Where id=514 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(514,'اقليد',51,5,'546',1)
Go

if not Exists(Select * From t00Region Where id=515 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(515,'آباده',51,5,'551',1)
Go

if not Exists(Select * From t00Region Where id=516 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(516,'باشت',52,5,'936',1)
Go

if not Exists(Select * From t00Region Where id=517 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(517,'چرام',52,5,'937',1)
Go

if not Exists(Select * From t00Region Where id=518 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(518,'دوگنبدان',52,5,'720',1)
Go

if not Exists(Select * From t00Region Where id=519 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(519,'دهدشت',52,5,'722',1)
Go

if not Exists(Select * From t00Region Where id=520 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(520,'ديشموك',52,5,'933',1)
Go

if not Exists(Select * From t00Region Where id=521 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(521,'دنا',52,5,'631',1)
Go

if not Exists(Select * From t00Region Where id=522 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(522,'سي سخت',52,5,'721',1)
Go

if not Exists(Select * From t00Region Where id=523 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(523,'سوق',52,5,'1026',1)
Go

if not Exists(Select * From t00Region Where id=524 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(524,'ليكك',52,5,'935',1)
Go

if not Exists(Select * From t00Region Where id=525 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(525,'گچساران',52,5,'625',1)
Go

if not Exists(Select * From t00Region Where id=526 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(526,'قلعه رئيسي',52,5,'934',1)
Go

if not Exists(Select * From t00Region Where id=527 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(527,'ياسوج',52,5,'560',1)
Go

if not Exists(Select * From t00Region Where id=528 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(528,'قشم',53,5,'562',1)
Go

if not Exists(Select * From t00Region Where id=529 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(529,'گوهران',53,5,'727',1)
Go

if not Exists(Select * From t00Region Where id=530 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(530,'هرمز',53,5,'855',1)
Go

if not Exists(Select * From t00Region Where id=531 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(531,'ميناب',53,5,'728',1)
Go

if not Exists(Select * From t00Region Where id=532 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(532,'رودان',53,5,'512',1)
Go

if not Exists(Select * From t00Region Where id=533 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(533,'سيريك',53,5,'854',1)
Go

if not Exists(Select * From t00Region Where id=534 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(534,'دهبارز',53,5,'726',1)
Go

if not Exists(Select * From t00Region Where id=535 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(535,'درگهان',53,5,'853',1)
Go

if not Exists(Select * From t00Region Where id=536 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(536,'چارك',53,5,'851',1)
Go

if not Exists(Select * From t00Region Where id=537 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(537,'حاجي آباد',53,5,'725',1)
Go

if not Exists(Select * From t00Region Where id=538 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(538,'جاسك',53,5,'730',1)
Go

if not Exists(Select * From t00Region Where id=539 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(539,'پارسيان',53,5,'1007',1)
Go

if not Exists(Select * From t00Region Where id=540 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(540,'بندرخمير',53,5,'852',1)
Go

if not Exists(Select * From t00Region Where id=541 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(541,'بندرعباس',53,5,'561',1)
Go

if not Exists(Select * From t00Region Where id=542 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(542,'بندرلنگه',53,5,'723',1)
Go

if not Exists(Select * From t00Region Where id=543 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(543,'بستك',53,5,'724',1)
Go

if not Exists(Select * From t00Region Where id=544 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(544,'ابوموسي',53,5,'729',1)
Go

if not Exists(Select * From t00Region Where id=545 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(545,'ابدان',54,5,'976',1)
Go

if not Exists(Select * From t00Region Where id=546 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(546,'آبپخش',54,5,'954',1)
Go

if not Exists(Select * From t00Region Where id=547 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(547,'آباد',54,5,'962',1)
Go

if not Exists(Select * From t00Region Where id=548 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(548,'امام حسن',54,5,'979',1)
Go

if not Exists(Select * From t00Region Where id=549 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(549,'اهرم',54,5,'733',1)
Go

if not Exists(Select * From t00Region Where id=550 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(550,'بندركنگان',54,5,'569',1)
Go

if not Exists(Select * From t00Region Where id=551 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(551,'بنهگز',54,5,'961',1)
Go

if not Exists(Select * From t00Region Where id=552 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(552,'بندرگناوه',54,5,'570',1)
Go

if not Exists(Select * From t00Region Where id=553 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(553,'بندردير',54,5,'567',1)
Go

if not Exists(Select * From t00Region Where id=554 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(554,'بندرديلم',54,5,'568',1)
Go

if not Exists(Select * From t00Region Where id=555 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(555,'بندرريگ',54,5,'875',1)
Go

if not Exists(Select * From t00Region Where id=556 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(556,'بوشهر',54,5,'564',1)
Go

if not Exists(Select * From t00Region Where id=557 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(557,'برازجان',54,5,'734',1)
Go

if not Exists(Select * From t00Region Where id=558 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(558,'بردخون',54,5,'977',1)
Go

if not Exists(Select * From t00Region Where id=559 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(559,'بادوله',54,5,'970',1)
Go

if not Exists(Select * From t00Region Where id=560 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(560,'تنگ آرم',54,5,'951',1)
Go

if not Exists(Select * From t00Region Where id=561 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(561,'تنگستان',54,5,'565',1)
Go

if not Exists(Select * From t00Region Where id=562 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(562,'جزيره خارك',54,5,'735',1)
Go

if not Exists(Select * From t00Region Where id=563 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(563,'جم',54,5,'872',1)
Go

if not Exists(Select * From t00Region Where id=564 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(564,'چهارروستائي',54,5,'974',1)
Go

if not Exists(Select * From t00Region Where id=565 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(565,'دالكي',54,5,'952',1)
Go

if not Exists(Select * From t00Region Where id=566 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(566,'دشتستان',54,5,'566',1)
Go

if not Exists(Select * From t00Region Where id=567 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(567,'دلوار',54,5,'871',1)
Go

if not Exists(Select * From t00Region Where id=568 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(568,'خورموج',54,5,'732',1)
Go

if not Exists(Select * From t00Region Where id=569 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(569,'شبانكاره',54,5,'950',1)
Go

if not Exists(Select * From t00Region Where id=570 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(570,'شول',54,5,'975',1)
Go

if not Exists(Select * From t00Region Where id=571 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(571,'شنبه',54,5,'969',1)
Go

if not Exists(Select * From t00Region Where id=572 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(572,'عسلويه',54,5,'874',1)
Go

if not Exists(Select * From t00Region Where id=573 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(573,'ريز',54,5,'960',1)
Go

if not Exists(Select * From t00Region Where id=574 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(574,'سعدآباد',54,5,'949',1)
Go

if not Exists(Select * From t00Region Where id=575 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(575,'نخل تقي',54,5,'958',1)
Go

if not Exists(Select * From t00Region Where id=576 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(576,'كلمه',54,5,'873',1)
Go

if not Exists(Select * From t00Region Where id=577 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(577,'وحدتيه',54,5,'953',1)
Go

if not Exists(Select * From t00Region Where id=578 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(578,'كاكي',54,5,'968',1)
Go

if not Exists(Select * From t00Region Where id=579 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(579,'كبودرآهنگ',55,5,'577',1)
Go

if not Exists(Select * From t00Region Where id=580 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(580,'ملاير',55,5,'574',1)
Go

if not Exists(Select * From t00Region Where id=581 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(581,'همدان',55,5,'573',1)
Go

if not Exists(Select * From t00Region Where id=582 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(582,'نهاوند',55,5,'576',1)
Go

if not Exists(Select * From t00Region Where id=583 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(583,'قروه درجزين',55,5,'1033',1)
Go

if not Exists(Select * From t00Region Where id=584 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(584,'قهاوند',55,5,'903',1)
Go

if not Exists(Select * From t00Region Where id=585 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(585,'صالح آباد',55,5,'1055',1)
Go

if not Exists(Select * From t00Region Where id=586 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(586,'فامنين',55,5,'1060',1)
Go

if not Exists(Select * From t00Region Where id=587 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(587,'رزن',55,5,'578',1)
Go

if not Exists(Select * From t00Region Where id=588 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(588,'جورقان',55,5,'902',1)
Go

if not Exists(Select * From t00Region Where id=589 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(589,'تويسركان',55,5,'575',1)
Go

if not Exists(Select * From t00Region Where id=590 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(590,'بهار',55,5,'737',1)
Go

if not Exists(Select * From t00Region Where id=591 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(591,'اسدآباد',55,5,'736',1)
Go

if not Exists(Select * From t00Region Where id=592 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(592,'اسلام آباد غرب',56,5,'580',1)
Go

if not Exists(Select * From t00Region Where id=593 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(593,'جوانرود',56,5,'589',1)
Go

if not Exists(Select * From t00Region Where id=594 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(594,'بيستون',56,5,'773',1)
Go

if not Exists(Select * From t00Region Where id=595 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(595,'تازه آباد',56,5,'901',1)
Go

if not Exists(Select * From t00Region Where id=596 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(596,'پاوه',56,5,'588',1)
Go

if not Exists(Select * From t00Region Where id=597 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(597,'دالاهو',56,5,'775',1)
Go

if not Exists(Select * From t00Region Where id=598 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(598,'صحنه',56,5,'587',1)
Go

if not Exists(Select * From t00Region Where id=599 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(599,'سرپل ذهاب',56,5,'581',1)
Go

if not Exists(Select * From t00Region Where id=600 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(600,'سنقر',56,5,'583',1)
Go

if not Exists(Select * From t00Region Where id=601 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(601,'سومار',56,5,'899',1)
Go

if not Exists(Select * From t00Region Where id=602 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(602,'روانسر',56,5,'774',1)
Go

if not Exists(Select * From t00Region Where id=603 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(603,'قصرشيرين',56,5,'584',1)
Go

if not Exists(Select * From t00Region Where id=604 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(604,'گيلانغرب',56,5,'585',1)
Go

if not Exists(Select * From t00Region Where id=605 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(605,'هرسين',56,5,'586',1)
Go

if not Exists(Select * From t00Region Where id=606 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(606,'كرمانشاه',56,5,'579',1)
Go

if not Exists(Select * From t00Region Where id=607 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(607,'كرند غرب',56,5,'900',1)
Go

if not Exists(Select * From t00Region Where id=608 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(608,'كنگاور',56,5,'582',1)
Go

if not Exists(Select * From t00Region Where id=609 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(609,'مهران',57,5,'591',1)
Go

if not Exists(Select * From t00Region Where id=610 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(610,'سرابله',57,5,'738',1)
Go

if not Exists(Select * From t00Region Where id=611 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(611,'دهلران',57,5,'592',1)
Go

if not Exists(Select * From t00Region Where id=612 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(612,'دره شهر',57,5,'595',1)
Go

if not Exists(Select * From t00Region Where id=613 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(613,'اركواز',57,5,'1013',1)
Go

if not Exists(Select * From t00Region Where id=614 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(614,'آبدانان',57,5,'593',1)
Go

if not Exists(Select * From t00Region Where id=615 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(615,'ايوان',57,5,'596',1)
Go

if not Exists(Select * From t00Region Where id=616 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(616,'ايلام',57,5,'590',1)
Go

if not Exists(Select * From t00Region Where id=617 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(617,'بدره',57,5,'1039',1)
Go

if not Exists(Select * From t00Region Where id=618 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(618,'آستانه',58,5,'1047',1)
Go

if not Exists(Select * From t00Region Where id=619 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(619,'آشتيان',58,5,'598',1)
Go

if not Exists(Select * From t00Region Where id=620 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(620,'اراك',58,5,'597',1)
Go

if not Exists(Select * From t00Region Where id=621 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(621,'دليجان',58,5,'601',1)
Go

if not Exists(Select * From t00Region Where id=622 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(622,'خنداب',58,5,'898',1)
Go

if not Exists(Select * From t00Region Where id=623 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(623,'خمين',58,5,'600',1)
Go

if not Exists(Select * From t00Region Where id=624 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(624,'پرندك',58,5,'897',1)
Go

if not Exists(Select * From t00Region Where id=625 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(625,'تفرش',58,5,'599',1)
Go

if not Exists(Select * From t00Region Where id=626 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(626,'توره',58,5,'1049',1)
Go

if not Exists(Select * From t00Region Where id=627 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(627,'ساوه',58,5,'602',1)
Go

if not Exists(Select * From t00Region Where id=628 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(628,'شازند',58,5,'739',1)
Go

if not Exists(Select * From t00Region Where id=629 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(629,'شهرجديدمهاجران',58,5,'1048',1)
Go

if not Exists(Select * From t00Region Where id=630 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(630,'محلات',58,5,'604',1)
Go

if not Exists(Select * From t00Region Where id=631 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(631,'كميجان',58,5,'895',1)
Go

if not Exists(Select * From t00Region Where id=632 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(632,'كامياران',59,5,'610',1)
Go

if not Exists(Select * From t00Region Where id=633 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(633,'قروه',59,5,'611',1)
Go

if not Exists(Select * From t00Region Where id=634 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(634,'مريوان',59,5,'612',1)
Go

if not Exists(Select * From t00Region Where id=635 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(635,'صاحب',59,5,'925',1)
Go

if not Exists(Select * From t00Region Where id=636 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(636,'سروآباد',59,5,'929',1)
Go

if not Exists(Select * From t00Region Where id=637 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(637,'سنندج',59,5,'605',1)
Go

if not Exists(Select * From t00Region Where id=638 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(638,'سقز',59,5,'609',1)
Go

if not Exists(Select * From t00Region Where id=639 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(639,'بيجار',59,5,'608',1)
Go

if not Exists(Select * From t00Region Where id=640 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(640,'دلبران',59,5,'927',1)
Go

if not Exists(Select * From t00Region Where id=641 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(641,'دزج',59,5,'926',1)
Go

if not Exists(Select * From t00Region Where id=642 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(642,'ديواندره',59,5,'606',1)
Go

if not Exists(Select * From t00Region Where id=643 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(643,'دهگلان',59,5,'928',1)
Go

if not Exists(Select * From t00Region Where id=644 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(644,'بانه',59,5,'607',1)
Go

if not Exists(Select * From t00Region Where id=645 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(645,'بشرويه',60,5,'628',1)
Go

if not Exists(Select * From t00Region Where id=646 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(646,'اسفدن',60,5,'938',1)
Go

if not Exists(Select * From t00Region Where id=647 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(647,'اسلاميه',60,5,'940',1)
Go

if not Exists(Select * From t00Region Where id=648 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(648,'بيرجند',60,5,'741',1)
Go

if not Exists(Select * From t00Region Where id=649 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(649,'حاجي آباد',60,5,'939',1)
Go

if not Exists(Select * From t00Region Where id=650 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(650,'سربيشه',60,5,'743',1)
Go

if not Exists(Select * From t00Region Where id=651 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(651,'سرايان',60,5,'717',1)
Go

if not Exists(Select * From t00Region Where id=652 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(652,'طبس',60,5,'1015',1)
Go

if not Exists(Select * From t00Region Where id=653 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(653,'فردوس',60,5,'509',1)
Go

if not Exists(Select * From t00Region Where id=654 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(654,'نهبندان',60,5,'742',1)
Go

if not Exists(Select * From t00Region Where id=655 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(655,'قائن',60,5,'711',1)
Go

if not Exists(Select * From t00Region Where id=656 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(656,'قاضي',61,5,'942',1)
Go

if not Exists(Select * From t00Region Where id=657 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(657,'مانه',61,5,'756',1)
Go

if not Exists(Select * From t00Region Where id=658 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(658,'گرمه',61,5,'941',1)
Go

if not Exists(Select * From t00Region Where id=659 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(659,'فاروج',61,5,'944',1)
Go

if not Exists(Select * From t00Region Where id=660 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(660,'شيروان',61,5,'747',1)
Go

if not Exists(Select * From t00Region Where id=661 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(661,'جاجرم',61,5,'746',1)
Go

if not Exists(Select * From t00Region Where id=662 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(662,'پيش قلعه',61,5,'943',1)
Go

if not Exists(Select * From t00Region Where id=663 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(663,'درق',61,5,'1061',1)
Go

if not Exists(Select * From t00Region Where id=664 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(664,'اسفراين',61,5,'745',1)
Go

if not Exists(Select * From t00Region Where id=665 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(665,'آشخانه',61,5,'748',1)
Go

if not Exists(Select * From t00Region Where id=666 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(666,'بجنورد',61,5,'744',1)
Go

if not Exists(Select * From t00Region Where id=667 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(667,'ايور',61,5,'1062',1)
Go

if not Exists(Select * From t00Region Where id=668 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(668,'آسارا',62,5,'1004',1)
Go

if not Exists(Select * From t00Region Where id=669 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(669,'اشتهارد',62,5,'1005',1)
Go

if not Exists(Select * From t00Region Where id=670 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(670,'طالقان',62,5,'948',1)
Go

if not Exists(Select * From t00Region Where id=671 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(671,'ساوجبلاغ',62,5,'945',1)
Go

if not Exists(Select * From t00Region Where id=672 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(672,'محمد شهر',62,5,'947',1)
Go

if not Exists(Select * From t00Region Where id=673 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(673,'نظرآباد',62,5,'423',1)
Go

if not Exists(Select * From t00Region Where id=674 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(674,'هشتگرد',62,5,'668',1)
Go

if not Exists(Select * From t00Region Where id=675 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(675,'مشكين دشت',62,5,'946',1)
Go

if not Exists(Select * From t00Region Where id=676 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(676,'كرج',62,5,'415',1)
Go

if not Exists(Select * From t00Region Where id=677 )
INSERT INTO [t00Region]([id],[name],[parentID],[regionTypeID],[code],[height]) 
Values(677,'كمال شهر',62,5,'1014',1)
Go

Set IDENTITY_INSERT [t00Region] OFF
Alter Table [t00Region] Enable Trigger All
Go