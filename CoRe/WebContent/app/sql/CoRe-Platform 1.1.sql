CREATE DATABASE  IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `test`;
-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	5.5.38-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `date` date NOT NULL,
  `userId` int(11) NOT NULL,
  `topicId` int(11) DEFAULT NULL,
  `reviewId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_comment_1_idx` (`userId`),
  KEY `fk_comment_2_idx` (`topicId`),
  KEY `fk_comment_3_idx` (`reviewId`),
  CONSTRAINT `fk_comment_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_2` FOREIGN KEY (`topicId`) REFERENCES `topic` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_3` FOREIGN KEY (`reviewId`) REFERENCES `review` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (11,'uraaa','2014-05-09',17,NULL,NULL),(12,'it works!','2014-05-09',17,NULL,11),(13,'it works too!','2014-05-09',17,NULL,11),(14,'it works too!','2014-05-09',17,NULL,11),(124,'This is now resolved. The search term is just fetching the results directly from the query so I had to adjust that to fix it.\n\nBefore\n\nWHERE    LastName LIKE \'%\' + @LastName + \'%\'\nAfter\n\nWHERE    A.[LastName] + \', \' + A.[FirstName] LIKE \'%\' + @term + \'%\'','2014-06-25',17,101,NULL),(125,'That works!!','2014-06-25',17,NULL,84),(126,'The second solution should be fine. Can we see your PHP where you query the DB with the string? –','2014-06-25',19,101,NULL),(127,'I tried this as well. tokenSeparators: [\' \'],. I set it to space and left in my comma and it didn\'t work. I also removed the comma and did LastName FirstName and as soon as I hit space, it said no results','2014-06-25',29,101,NULL),(128,'Updated OP with the requested info –','2014-06-25',24,NULL,84),(129,'can you try separator: \" \", instead of tokenSeparators: [\" \"]','2014-06-25',24,101,NULL),(130,'Same issue, just says no results as soon as I hit the comma. I\'m wondering if the search functionality is searching on the term (last name) vs the result which contains the full name as the tex','2014-06-25',19,101,NULL),(131,'works for me','2014-06-25',19,NULL,84),(132,'It is something wrong. Doesn\'t work!','2014-06-25',18,NULL,85),(133,'Line 2 must be set to \"false\"','2014-06-25',29,NULL,85),(134,'Helps me a lot! Thank you!','2014-06-25',29,NULL,84),(135,'It\'s ok to be serializable','2014-06-25',29,102,NULL),(136,'I forgot to add an extra import','2014-06-25',29,NULL,86),(137,'Good','2014-06-25',17,NULL,86),(138,'Helps me a lot!','2014-06-25',17,102,NULL),(139,'Doesn\'t work, @Radu','2014-06-25',18,102,NULL),(140,'Great job!','2014-06-25',18,NULL,87),(141,'You can remove line 13','2014-06-25',18,58,NULL),(142,'nice\n','2014-06-25',29,NULL,84),(143,'df','2014-10-24',17,113,NULL),(158,'asdf','2014-10-29',18,112,NULL),(159,'fff','2014-10-29',18,NULL,113),(165,'sdf','2014-10-29',18,129,NULL),(169,'sad','2014-10-31',18,NULL,123),(170,'dd','2014-10-31',18,133,NULL);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES (31,'supergroup'),(32,'group11'),(34,'Group12'),(50,'group2r'),(51,'group3'),(59,'Groupx'),(62,'test'),(64,'safd'),(65,'sad');
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `code` longtext NOT NULL,
  `date` date NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `topicId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_answers_1_idx` (`userId`),
  KEY `fk_answers_2_idx` (`topicId`),
  CONSTRAINT `fk_review_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_2` FOREIGN KEY (`topicId`) REFERENCES `topic` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (11,'You could make a struct factory.','function makeStruct(names) {\n  var names = names.split(\' \');\n  var count = names.length;\n  function constructor() {\n    for (var i = 0; i < count; i++) {\n      this[names[i]] = arguments[i];\n    }\n  }\n  return constructor;\n}\n\nvar Item = makeStruct(\"id speaker country\");\nvar row = new Item(1, \'john\', \'au\');\nalert(row.speaker); // displays: john','2014-05-08',18,13),(18,'mmm','function makeStruct(names) {\n  var names = names.split(\' \');\n  var count = names.length;\n  function constructor() {\n    for (var i = 0; i < count; i++) {\n      this[names[i]] = arguments[i];\n    }\n  }\n  return constructor;\n}\n\nvar Item = makeStruct(\"id speaker country\");\nvar row = new Item(1, \'john\', \'au\');\nalert(row.speaker); \n//review','2014-05-25',17,13),(23,'desc2','code2','2014-05-27',17,NULL),(43,'desc','import java.io.*;\nimport java.util.*;\nimport java.util.concurrent.TimeUnit;\n\n\nclass search\n{\n   protected int name;\n   private int numelem;\n   private int[] input=new int[100];\n \n\npublic void setNumofelem()\n{\n \n  System.out.println(\"Enter the total numebr of elements\");\n  Scanner yz=new Scanner(System.in);\n  numelem=yz.nextInt();\n\n}\npublic void randomnumber() throws Exception\n{\n\n    int max=500,min=1,n=numelem;\n   Random rand = new Random(); \n for (int j=0;j < n;j++){\n    Double d=43.23;\n    input[j]=rand.nextInt(max)+1;\n\n } \n}\n\npublic void printinput()\n{ \n  int b=numelem,t=0;\n  while(true){\n    if(b!=0)\n    {\n     \n       System.out.print(\"  \"+input[t]);\n         b--;\n         t++;\n    }\n    else\n    \n    break;\n    \n    }\n\n}\npublic class mycode{\n  public static void main(String args[]) throws Exception{\n \n \n   search a=new search();\n   a.setNumofelem();\n   a.randomnumber();\n   a.printinput();\n  }\n}','2014-06-09',17,58),(44,'This is a review','import java.io.*;\nimport java.util.*;\nimport java.util.concurrent.TimeUnit;\nimport java.util.List;\n\nclass search\n{\n   private int numelem;\n   private int[] input=new int[100];\n   protected int name;\n\npublic void setNumofelem()\n{\n  String aux=\"string1\";\n  System.out.println(\"Enter the total numebr of elements\");\n  Scanner yz=new Scanner(System.in);\n  numelem=yz.nextInt();\n\n}\npublic void randomnumber() throws Exception\n{\n    System.out.println(\"redundant message\");\n    int max=500,min=1,n=numelem;\n   Random rand = new Random(); \n for (int j=0;j < n;j++)\n {\n    Double d=43.23;\n   input[j]=rand.nextInt(max)+1;\n\n} \n}\n\npublic void printinput()\n{ \n  int b=numelem,t=0;\n  while(true)\nif(b!=0)\n{\n    System.out.println(\"another redundant message\");\n   System.out.print(\"  \"+input[t]);\n     b--;\n     t++;\n}\nelse\nbreak;\n}\n\n}\npublic class mycode\n{\n  public static void main(String args[]) throws Exception\n{\n    Integer x=123;\n   search a=new search();\n   a.setNumofelem();\n   a.randomnumber();\n   Integer y=443;\n   a.printinput();\n}\n}\n///reviewwww','2014-06-09',17,58),(45,'d','	@RequestMapping(value = \"/app/insertReview\", method = RequestMethod.POST)\n	public @ResponseBody String postAnswer(@RequestParam(value = \"reviewCode\", required = false) String reviewCode,\n			@RequestParam(value = \"reviewDescription\", required = false) String reviewDescription,\n			@RequestParam(value = \"topicId\", required = false) Integer topicId,\n			ModelMap model,\n			HttpServletRequest request) {\n		User user=(User) request.getSession().getAttribute(\"user\");\n		TopicService ts = new TopicService();\n		Topic topic = ts.getTopicById(topicId);\n		PostAnswerService pas = new PostAnswerService();\n		pas.insertReview(reviewCode, reviewDescription, user, topic);\n		Date d =new Date();\n		return d.toString();\n	}\n	','2014-06-09',17,58),(77,'saddsa','zs','2014-06-14',17,87),(79,'d','static BOOL WINAPI console_ctrl_handler(DWORD dwCtrlType)\n    {\n      switch (dwCtrlType)\n      {\n      case CTRL_C_EVENT: // Ctrl+C\n          { \n\n              break;\n            //return TRUE;\n          }\n\n      case CTRL_BREAK_EVENT: // Ctrl+Break\n        break;\n      case CTRL_CLOSE_EVENT: // Closing the console window //event was caught\n//But I guess call exitProcess ()\n        break;\n        //return TRUE;  \n      case CTRL_LOGOFF_EVENT: // User logs off. Passed only to services!\n        break;\n      case CTRL_SHUTDOWN_EVENT: // System is shutting down. Passed only to services!\n        break;\n      }\n\n      // Return TRUE if handled this message, further handler functions won\'t be called.\n      // Return FALSE to pass this message to further handlers until default handler calls ExitProcess().\n      return TRUE;\n    }','2014-06-17',19,54),(84,'I\'ve changed some parameters','$(\"#requiredAttendees\").select2({\n            multiple: false,\n            minimumInputLength: 3,\n            placeholder: \"Search for employee!!\",\n            tokenSeparators: [\" \"],\n            ajax: { \n                url: \"json-User.php\",\n                dataType: \'json\',\n                data: function (term) {\n                    return {\n                        term: term, // search term\n                    };\n                },\n                results: function (data) { // parse the results into the format expected by Select2.\n                    return {results: info};\n                }\n            },\n        });\n    ','2014-06-25',18,101),(85,'I changed minimunInputLength to 4','$(\"#requiredAttendees\").select2({\n            multiple: true,\n            minimumInputLength: 4, //this should be 4 or 5\n            placeholder: \"Search for employee!!\",\n            tokenSeparators: [\" \"],\n            ajax: { \n                url: \"json-User.php\",\n                dataType: \'json\',\n                data: function (term) {\n                    return {\n                        term: term, // search term\n                    };\n                },\n                results: function (data) { // parse the results into the format expected by Select2.\n                    return {results: info};\n                }\n            },\n        });\n    ','2014-06-25',19,101),(86,'description','// default package\n// Generated May 5, 2014 4:46:39 PM by Hibernate Tools 4.0.0\npackage org.coreplatform.entity;\nimport java.util.HashSet;\nimport java.util.Set;\n\n/**\n * Tags generated by hbm2java\n */\npublic class Tags implements java.io.Serializable {\n\n	private Integer id;\n	private String title;\n	private Set topicses = new HashSet(0);\n\n	public Tags() {\n	}\n\n	public Tags(String title, Set topicses) {\n		this.title = title;\n		this.topicses = topicses;\n	}\n\n\n	public String getTitle() {\n		return this.title;\n	}\n\n	public void setTitle(String title) {\n		this.title = title;\n	}\n\n	public Set getTopicses() {\n		return this.topicses;\n	}\n\n	public void setTopicses(Set topicses) {\n		this.topicses = topicses;\n	}\n	\n	\n	public Integer getId() {\n		return this.id;\n	}\n\n	public void setId(Integer id) {\n		this.id = id;\n	}\n\n}//review\n','2014-06-25',29,102),(87,'Try this','// default package\n// Generated May 5, 2014 4:46:39 PM by Hibernate Tools 4.0.0\npackage org.coreplatform.entity;\nimport java.util.HashSet;\nimport java.util.Set;\n\n\n\n/**\n * Tags generated by hbm2java\n */\npublic class Tags {\n\n	private Integer id;\n	private String title;\n	private Set topicses = new HashSet(0);\n	private String sm;\n\n	public Tags() {\n	}\n\n	public Tags(String title, Set topicses) {\n		this.title = title;\n		this.topicses = topicses;\n	}\n\n	public Integer getId() {\n		return this.id;\n	}\n\n	public void setId(Integer id) {\n		this.id = id;\n	}\n\n	public String getTitle() {\n		return this.title;\n	}\n\n	public void setTitle(String title) {\n		this.title = title;\n	}\n\n	public Set getTopicses() {\n		return this.topicses;\n	}\n\n	public void setTopicses(Set topicses) {\n		this.topicses = topicses;\n	}\n\n}\n','2014-06-25',17,102),(88,'We can also determine that else if can not be one keyword by realizing that keywords are identifiers and we can see from the grammar for an identifier in my answer to Can you start a class name with a numeric digit? that spaces are not allowed in identifiers and so therefore else if can not be a single keyword but must be two separate keywords.','if \n{\n  statement_0;\n}\nelse\n{ \n  if\n  {\n    statement_1;\n   }\n}','2014-06-25',18,103),(97,'sad','<?xml version=\"1.0\"?>\n<!DOCTYPE hibernate-mapping PUBLIC \"-//Hibernate/Hibernate Mapping DTD 3.0//EN\"\n                                   \"http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd\">\n<!-- Generated May 5, 2014 4:46:39 PM by Hibernate Tools 4.0.0 -->\n<hibernate-mapping package=\"org.coreplatform.entity\">\n <class catalog=\"test\" name=\"Tags\" table=\"tags\">\n  <id name=\"id\" type=\"java.lang.Integer\">\n   <column name=\"id\"/>\n   <generator class=\"identity\"/>\n  </id>\n  <property generated=\"never\" lazy=\"false\" name=\"title\" type=\"string\">\n   <column length=\"50\" name=\"title\"/>\n  </property>\n  <set fetch=\"select\" inverse=\"true\" lazy=\"true\" name=\"topicses\"\n   sort=\"unsorted\" table=\"topics\">\n   <key>\n    <column name=\"tagId\"/>\n   </key>\n   <one-to-many class=\"Topics\"/>\n  </set>\n </class>\n</hibernate-mapping>\n','2014-06-26',19,111),(98,'asd','sdad','2014-10-25',18,NULL),(99,'asd','asd','2014-10-26',18,NULL),(113,'fds','sadf','2014-10-29',18,112),(114,'f','asdffsdfsdf','2014-10-29',18,112),(116,'asdas','asdasdasd','2014-10-29',18,127),(119,'asdf','asdf','2014-10-29',18,129),(121,'asd','asd','2014-10-29',18,132),(122,'asd','asda','2014-10-30',18,129),(123,'dasdsa','asdasd','2014-10-30',18,133),(124,'dsa','sda','2014-10-30',18,133),(126,'d','d','2014-10-31',18,127),(127,'fff','fff','2014-10-31',18,127);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'java'),(2,'javascript'),(3,'css'),(4,'html'),(5,'csharp'),(6,'php'),(7,'json'),(8,'python'),(9,'ruby'),(10,'sql'),(11,'prolog'),(12,'perl'),(13,'scala'),(14,'r'),(15,'lisp'),(16,'matlab'),(17,'jsp'),(18,'haskell'),(19,'django'),(20,'cobol'),(21,'c_cpp'),(22,'actionscript');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `testcol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `code` longtext NOT NULL,
  `date` date NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `tagId` int(11) DEFAULT NULL,
  `groupId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_topics_1_idx` (`userId`),
  KEY `fk_topics_2_idx` (`tagId`),
  KEY `fk_topics_3_idx` (`groupId`),
  CONSTRAINT `fk_topics_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_topics_3` FOREIGN KEY (`groupId`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_topic_1` FOREIGN KEY (`tagId`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (13,'Structs in Javascript','Previously, when I needed to store a number of related variables, I\'d create a class.\n\nBut I\'m wondering if this is a good practice. Are there any other, better ways to simulate a struct in Javascript?','function makeStruct(names) {\n  var names = names.split(\' \');\n  var count = names.length;\n  function constructor() {\n    for (var i = 0; i < count; i++) {\n      this[names[i]] = arguments[i];\n    }\n  }\n  return constructor;\n}\n\nvar Item = makeStruct(\"id speaker country\");\nvar row = new Item(1, \'john\', \'au\');\nalert(row.speaker); // displays: john','2014-05-08',18,2,NULL),(54,'How to prevent Normal users from terminating process?','another description','static BOOL WINAPI console_ctrl_handler(DWORD dwCtrlType)\n    {\n      switch (dwCtrlType)\n      {\n      case CTRL_C_EVENT: // Ctrl+C\n          { \n\n              break;\n            //return TRUE;\n          }\n\n      case CTRL_BREAK_EVENT: // Ctrl+Break\n        break;\n      case CTRL_CLOSE_EVENT: // Closing the console window //event was caught\n//But I guess call exitProcess ()\n        break;\n        //return TRUE;  \n      case CTRL_LOGOFF_EVENT: // User logs off. Passed only to services!\n        break;\n      case CTRL_SHUTDOWN_EVENT: // System is shutting down. Passed only to services!\n        break;\n      }\n\n      // Return TRUE if handled this message, further handler functions won\'t be called.\n      // Return FALSE to pass this message to further handlers until default handler calls ExitProcess().\n      return TRUE;\n    }','2014-06-07',17,5,NULL),(58,'redundant lines of code','desc','import java.io.*;\nimport java.util.*;\nimport java.util.concurrent.TimeUnit;\nimport java.util.List;\n\nclass search\n{\n   private int numelem;\n   private int[] input=new int[100];\n   protected int name;\n\npublic void setNumofelem()\n{\n  String aux=\"string1\";\n  System.out.println(\"Enter the total numebr of elements\");\n  Scanner yz=new Scanner(System.in);\n  numelem=yz.nextInt();\n\n}\npublic void randomnumber() throws Exception\n{\n    System.out.println(\"redundant message\");\n    int max=500,min=1,n=numelem;\n   Random rand = new Random(); \n for (int j=0;j < n;j++)\n {\n    Double d=43.23;\n   input[j]=rand.nextInt(max)+1;\n\n} \n}\n\npublic void printinput()\n{ \n  int b=numelem,t=0;\n  while(true)\nif(b!=0)\n{\n    System.out.println(\"another redundant message\");\n   System.out.print(\"  \"+input[t]);\n     b--;\n     t++;\n}\nelse\nbreak;\n}\n\n}\npublic class mycode\n{\n  public static void main(String args[]) throws Exception\n{\n    Integer x=123;\n   search a=new search();\n   a.setNumofelem();\n   a.randomnumber();\n   Integer y=443;\n   a.printinput();\n}\n}','2014-06-09',17,22,32),(87,'Is Java “pass-by-reference” or “pass-by-value”?','I always thought Java was pass-by-reference; however I\'ve seen a couple of blog posts (for example, this blog) that claim it\'s not. I don\'t think I understand the distinction they\'re making.','public void foo(Dog d) {\n  d.getName().equals(\"Max\"); // true\n  d = new Dog(\"Fifi\");\n  d.getName().equals(\"Fifi\"); // true\n}\n\nDog aDog = new Dog(\"Max\");\nfoo(aDog);\naDog.getName().equals(\"Max\"); // true\n//jjjj','2014-06-13',18,22,NULL),(101,'jQuery Select2 Plugin using Ajax','I am using the Select2 plugin with Ajax to connect to my employee database. It allows to set up a meeting and choose all of the employees you want to invite.','$(\"#requiredAttendees\").select2({\n            multiple: true,\n            minimumInputLength: 3,\n            placeholder: \"Search for employee\",\n            tokenSeparators: [\" \"],\n            ajax: { \n                url: \"jsonUser.php\",\n                dataType: \'json\',\n                data: function (term) {\n                    return {\n                        term: term, // search term\n                    };\n                },\n                results: function (data) { // parse the results into the format expected by Select2.\n                    return {results: data};\n                }\n            },\n        });  \n        \n         //','2014-06-25',18,22,NULL),(102,'Serializable class','Tags class should be serializable like in the section code because that doesn\'t work for me? Does anyone have an idea?','// default package\n// Generated May 5, 2014 4:46:39 PM by Hibernate Tools 4.0.0\npackage org.coreplatform.entity;\nimport java.util.HashSet;\nimport java.util.Set;\n\n/**\n * Tags generated by hbm2java\n */\npublic class Tags implements java.io.Serializable {\n\n	private Integer id;\n	private String title;\n	private Set topicses = new HashSet(0);\n\n	public Tags() {\n	}\n\n	public Tags(String title, Set topicses) {\n		this.title = title;\n		this.topicses = topicses;\n	}\n\n	public Integer getId() {\n		return this.id;\n	}\n\n	public void setId(Integer id) {\n		this.id = id;\n	}\n\n	public String getTitle() {\n		return this.title;\n	}\n\n	public void setTitle(String title) {\n		this.title = title;\n	}\n\n	public Set getTopicses() {\n		return this.topicses;\n	}\n\n	public void setTopicses(Set topicses) {\n		this.topicses = topicses;\n	}\n\n}\n','2014-06-25',18,1,50),(103,'Is “else if” a single keyword?','Question:\n\nSyntactically, shall I treat else if as a single keyword? Or is it actually an nested if statement within the outer else like below?','if \n  statement_0;\nelse if\n  statement_1;','2014-06-25',18,21,32),(111,'titlu2','d','<?xml version=\"1.0\"?>\n<!DOCTYPE hibernate-mapping PUBLIC \"-//Hibernate/Hibernate Mapping DTD 3.0//EN\"\n                                   \"http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd\">\n<!-- Generated May 5, 2014 4:46:39 PM by Hibernate Tools 4.0.0 -->\n<hibernate-mapping package=\"org.coreplatform.entity\">\n <class catalog=\"test\" name=\"Topics\" table=\"topics\">\n  <id name=\"id\" type=\"java.lang.Integer\">\n   <column name=\"id\"/>\n   <generator class=\"identity\"/>\n  </id>\n  <many-to-one class=\"Tags\" fetch=\"select\" name=\"tags\">\n   <column name=\"tagId\"/>\n  </many-to-one>\n  <many-to-one class=\"Users\" fetch=\"select\" name=\"users\">\n   <column name=\"userId\"/>\n  </many-to-one>\n  <property generated=\"never\" lazy=\"false\" name=\"title\" type=\"string\">\n   <column length=\"65535\" name=\"title\"/>\n  </property>\n  <property generated=\"never\" lazy=\"false\" name=\"description\" type=\"string\">\n   <column length=\"65535\" name=\"description\"/>\n  </property>\n  <property generated=\"never\" lazy=\"false\" name=\"code\" type=\"string\">\n   <column name=\"code\"/>\n  </property>\n  <property generated=\"never\" lazy=\"false\" name=\"date\" type=\"date\">\n   <column length=\"10\" name=\"date\"/>\n  </property>\n  <set fetch=\"select\" inverse=\"true\" lazy=\"true\" name=\"answerses\"\n   sort=\"unsorted\" table=\"answers\">\n   <key>\n    <column name=\"topicId\"/>\n   </key>\n   <one-to-many class=\"Answers\"/>\n  </set>\n </class>\n</hibernate-mapping>\n','2014-06-26',19,4,59),(112,'asasd','asd','ads','2014-10-24',17,18,NULL),(113,'a','d','// default package\n// Generated May 5, 2014 4:46:39 PM by Hibernate Tools 4.0.0\npackage org.coreplatform.entity;\nimport java.util.Date;\nimport java.util.HashSet;\nimport java.util.Set;\n\n/**\n * Topics generated by hbm2java\n */\npublic class Topics implements java.io.Serializable {\n\n	private Integer id;\n	private Tags tags;\n	private Users users;\n	private String title;\n	private String description;\n	private String code;\n	private Date date;\n	private Set answerses = new HashSet(0);\n\n	public Topics() {\n	}\n\n	public Topics(Tags tags, Users users, String title, String description,\n			String code, Date date, Set answerses) {\n		this.tags = tags;\n		this.users = users;\n		this.title = title;\n		this.description = description;\n		this.code = code;\n		this.date = date;\n		this.answerses = answerses;\n	}\n\n	public Integer getId() {\n		return this.id;\n	}\n\n	public void setId(Integer id) {\n		this.id = id;\n	}\n\n	public Tags getTags() {\n		return this.tags;\n	}\n\n	public void setTags(Tags tags) {\n		this.tags = tags;\n	}\n\n	public Users getUsers() {\n		return this.users;\n	}\n\n	public void setUsers(Users users) {\n		this.users = users;\n	}\n\n	public String getTitle() {\n		return this.title;\n	}\n\n	public void setTitle(String title) {\n		this.title = title;\n	}\n\n	public String getDescription() {\n		return this.description;\n	}\n\n	public void setDescription(String description) {\n		this.description = description;\n	}\n\n	public String getCode() {\n		return this.code;\n	}\n\n	public void setCode(String code) {\n		this.code = code;\n	}\n\n	public Date getDate() {\n		return this.date;\n	}\n\n	public void setDate(Date date) {\n		this.date = date;\n	}\n\n	public Set getAnswerses() {\n		return this.answerses;\n	}\n\n	public void setAnswerses(Set answerses) {\n		this.answerses = answerses;\n	}\n\n}\n','2014-10-24',17,5,NULL),(127,'d','d','de','2014-10-29',18,22,51),(129,'asdfdsfd','sadf','asdf','2014-10-29',18,22,62),(132,'asd','ads','asd','2014-10-29',18,22,64),(133,'druiu','asdasd','adasd','2014-10-30',19,22,NULL),(134,'ad','ad','sd','2014-10-31',18,22,NULL),(135,'das','ad','sd','2014-10-31',18,22,65),(136,'das','ad','sd','2014-10-31',18,22,65),(137,'f','f','f','2014-10-31',18,22,65);
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (17,'Catalin','Burcea','burceacatalin','burceacatalin@email.com','e1adc3949ba59abbe56e057f2f883e'),(18,'Alina','Hornet','hornetalina','hornetalina@gmail.com','e1adc3949ba59abbe56e057f2f883e'),(19,'Marius','Druiu','druiumarius','druiumarius@email.com','e1adc3949ba59abbe56e057f2f883e'),(24,'Bogdan','Burcea','burceabogdan','burceabogdam@email.com','e1adc3949ba59abbe56e057f2f883e'),(25,'Mircea','Badea','mirceabadea','mirceabadea@email.com','e1adc3949ba59abbe56e057f2f883e'),(26,'Ionut','Laceanu','laceanuionut','laceanuionut@gmail.com','e1adc3949ba59abbe56e057f2f883e'),(28,'ciprian','scarlat','scarlatciprian','scarlatciprian@gmail.com','e1adc3949ba59abbe56e057f2f883e'),(29,'Radu','Filipescu','filipescuradu','filipescuradu@gmail.com','e1adc3949ba59abbe56e057f2f883e'),(31,'diana','mihai','mihaidiana','mihaidiana@gmail.com','e1adc3949ba59abbe56e057f2f883e'),(32,'viv','viv','vivivivi','vivivivi@emai.com','e1adc3949ba59abbe56e057f2f883e'),(33,'abcabc','abcabc','abcabc','abcabc@email.com','e1adc3949ba59abbe56e057f2f883e'),(34,'Catalin','Burcea','aaaaaaaaa','aa@email.com','e1adc3949ba59abbe56e057f2f883e');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `idUser` int(11) NOT NULL,
  `idGroup` int(11) NOT NULL,
  `date` date NOT NULL,
  `ownership` varchar(5) NOT NULL,
  PRIMARY KEY (`idUser`,`idGroup`),
  KEY `fk_user_group_2_idx` (`idGroup`),
  CONSTRAINT `fk_user_group_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_group_2` FOREIGN KEY (`idGroup`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
INSERT INTO `user_group` VALUES (17,31,'2014-06-04','yes'),(17,32,'2014-06-06','yes'),(17,34,'2014-06-08','no'),(17,50,'2014-06-13','no'),(17,51,'2014-06-13','no'),(17,62,'2014-10-29','no'),(17,64,'2014-10-29','no'),(17,65,'2014-10-31','no'),(18,31,'2014-06-04','no'),(18,32,'2014-06-06','no'),(18,34,'2014-06-08','no'),(18,50,'2014-06-13','yes'),(18,51,'2014-06-13','yes'),(18,62,'2014-10-29','yes'),(18,64,'2014-10-29','yes'),(18,65,'2014-10-31','yes'),(19,31,'2014-06-04','no'),(19,32,'2014-06-06','no'),(19,34,'2014-06-08','no'),(19,51,'2014-06-13','no'),(19,59,'2014-06-26','yes'),(24,34,'2014-06-08','no'),(24,64,'2014-10-29','no'),(25,34,'2014-06-08','yes'),(26,32,'2014-06-06','no'),(26,34,'2014-06-08','no'),(26,50,'2014-06-13','no'),(26,51,'2014-06-13','no'),(29,34,'2014-06-08','no'),(29,59,'2014-06-26','no'),(31,59,'2014-06-26','no'),(33,64,'2014-10-29','no'),(33,65,'2014-10-31','no');
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_review_vote`
--

DROP TABLE IF EXISTS `user_review_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_review_vote` (
  `userId` int(11) NOT NULL,
  `reviewId` int(11) NOT NULL,
  `stars` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`reviewId`),
  KEY `fk_user_review_vote_2` (`reviewId`),
  CONSTRAINT `fk_user_review_vote_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_review_vote_2` FOREIGN KEY (`reviewId`) REFERENCES `review` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_review_vote`
--

LOCK TABLES `user_review_vote` WRITE;
/*!40000 ALTER TABLE `user_review_vote` DISABLE KEYS */;
INSERT INTO `user_review_vote` VALUES (17,43,3),(17,44,1),(17,45,4),(17,77,4),(17,84,3),(17,86,4),(18,18,3),(18,43,4),(18,45,1),(18,79,2),(18,84,3),(18,85,4),(18,86,3),(18,87,5),(18,123,2),(18,124,4),(19,77,3),(19,79,4),(19,97,2),(24,18,3),(24,79,5),(25,18,2),(25,77,5),(25,79,3),(25,84,2),(25,85,3),(29,43,5),(29,44,2),(29,45,5),(29,77,2),(29,84,1),(29,85,5),(29,86,4),(31,44,4);
/*!40000 ALTER TABLE `user_review_vote` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-10-31 21:40:51
