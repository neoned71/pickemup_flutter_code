

abstract class Routes{

  //============================Common Routes for all!
  //Auth
  static const INITIAL = '/splash';

  static const OTP_VERIFICATION = '/otp_verification';
  static const FACULTY_OTP_VERIFICATION = '/faculty/otp_verification';

  static const LOGIN = '/login';
  static const FACULTY_LOGIN = '/faculty/login';

  static const ONBOARDING = '/onboarding';

  //INFO
  static const TERMS_CONDITIONS = '/terms_conditions';
  static const POLICY = '/policy';
  static const ABOUT = '/about';

  //==============================User Specific routes
  static const PROFILE = '/profile';
  static const FACULTY_PROFILE = '/faculty/profile';
  static const CREATE_LECTURE_PAGE = '/faculty/create_lecture';

  static const HOME = '/home';
  static const LANDING_PAGE = '/landing_page';
  static const FACULTY_HOME = '/faculty/home';

  static const EVENT = '/event';
  static const EVENT_TICKETS = '/event_tickets';
  static const EVENT_TYPE_EVENTS = '/event_type_events';
  static const BOOKINGS = '/bookings';
  static const BOOKING = '/booking';
  static const PAYMENT_BOOKING_STATUS = '/payment_status';

  static const MOLECULES_PAGE = '/molecules_page';
  static const IMAGE_VIEWER = '/image_viewer';
  static const SEARCH = '/search';
  static const NOTIFICATIONS = '/user_notifications';


  //===============================Host Specific Routes
  static const HOST_EVENT = '/host_event';
  static const HOST_HOME = '/host_home';
  static const HOST_BOOKINGS = '/host_bookings';
  static const HOST_PROFILE = '/host_profile';
  static const HOST_CREATE_EVENT = '/host_create_event';
  static const HOST_EVENT_DETAILS = '/host_event_details';
  static const HOST_SCANNER = '/host_scanner';
  static const HOST_SCANNED = '/host_scanned';
  static const HOST_WALLET = '/host_wallet';
  static const HOST_NOTIFICATIONS = '/host_notifications';
  static const HOST_HELPERS = '/host_helpers';
  static const HOST_ADD_HELPERS = '/host_add_new';
  static const HOST_EVENT_PHASES = '/host_event_phases';

  //===============================Host Specific Routes

  static const HELPER_SCANNED = '/helper_scanned';
  static const HELPER_SCANNER = '/helper_scanner';
  static const HELPER_HOME = '/helper_home';
  static const HELPER_EVENT = '/helper_event';
  static const HELPER_PROFILE = '/helper_profile';

  //=================================Student routes

  static const STREAMS = '/streams';

  static const EXAM_PAGE = '/exam_page';
  static const SUBJECTS_EXAM_PAGE = '/subjects_exam_page';
  static const CHAPTERS_EXAM_PAGE = '/chapters_exam_page';
  // static const EXAM_PAGE = '/exam_page';

  static const BATCH_PAGE = '/batch_page';
  static const BATCH_MODULE_SUBJECTS_PAGE = '/batch_module_subjects_page';
  static const BATCH_LECTURE_SUBJECTS_PAGE = '/batch_lecture_subjects_page';

  static const BATCH_FILE_SUBJECTS_PAGE = '/batch_file_subjects_page';
  static const BATCH_FILE_SUBJECT_CHAPTERS_PAGE = '/batch_file_subject_chapters_page';
  static const BATCH_SUBJECT_CHAPTER_FILES_PAGE = '/batch_subject_chapter_files_page';

  static const BATCH_SUBJECT_MODULES_PAGE = '/batch_subject_modules_page';
  static const BATCH_SUBJECT_LECTURES_PAGE = '/batch_subject_lectures_page';
  // static const BATCH_SUBJECT_FILES_CHAPTERS_PAGE = '/batch_subject_files_page';
  static const MODULE_PAGE = '/module_page';
  static const MODULE_CHAPTER_PAGE = '/module_chapter_page';
  static const LECTURE_CHAPTER_PAGE = '/lecture_chapter_page';
  static const LECTURE_PAGE = '/lecture_page';
  static const VIDEO_PAGE = '/video_page';
  static const QUIZ_PAGE = '/quiz_page';
  static const GRAVITY_AI_PAGE = '/gravity_ai_page';
  static const STREAM_PAGE = '/stream_page';
  static const TEST_REPORT_PAGE = '/test_report';
  static const TEST_PAGE = '/test_page';
  static const POST_TEST_PAGE = '/post_test_page';
  static const TEST_RESULT_QUESTION_PAGE = '/test_result_question_page';
  static const SINGLE_QUESTION_PAGE = '/single_question_page';
  static const TEST_RESULT_PAGE = '/test_result';



  // faculty pages
  static const FACULTY_STREAMS = '/faculty/streams';

  static const FACULTY_EXAM_PAGE = '/faculty/exam_page';
  static const FACULTY_SUBJECTS_EXAM_PAGE = '/faculty/subjects_exam_page';
  static const FACULTY_CHAPTERS_EXAM_PAGE = '/faculty/chapters_exam_page';
  // static const EXAM_PAGE = '/exam_page';

  static const FACULTY_BATCH_PAGE = '/faculty/batch_page';
  static const FACULTY_BATCH_MODULE_SUBJECTS_PAGE = '/faculty/batch_module_subjects_page';
  static const FACULTY_BATCH_LECTURE_SUBJECTS_PAGE = '/faculty/batch_lecture_subjects_page';

  static const FACULTY_BATCH_FILE_SUBJECTS_PAGE = '/faculty/batch_file_subjects_page';
  static const FACULTY_BATCH_FILE_SUBJECT_CHAPTERS_PAGE = '/faculty/batch_file_subject_chapters_page';
  static const FACULTY_BATCH_SUBJECT_CHAPTER_FILES_PAGE = '/faculty/batch_subject_chapter_files_page';

  static const FACULTY_BATCH_SUBJECT_MODULES_PAGE = '/faculty/batch_subject_modules_page';
  static const FACULTY_BATCH_SUBJECT_LECTURES_PAGE = '/faculty/batch_subject_lectures_page';
  // static const BATCH_SUBJECT_FILES_CHAPTERS_PAGE = '/batch_subject_files_page';
  static const FACULTY_MODULE_PAGE = '/faculty/module_page';
  static const FACULTY_MODULE_CHAPTER_PAGE = '/faculty/module_chapter_page';
  static const FACULTY_LECTURE_CHAPTER_PAGE = '/faculty/lecture_chapter_page';
  static const FACULTY_LECTURE_PAGE = '/faculty/lecture_page';
  static const FACULTY_VIDEO_PAGE = '/faculty/video_page';
  static const FACULTY_QUIZ_PAGE = '/faculty/quiz_page';
  static const FACULTY_GRAVITY_AI_PAGE = '/faculty/gravity_ai_page';
  static const FACULTY_STREAM_PAGE = '/faculty/stream_page';
  static const FACULTY_TEST_REPORT_PAGE = '/faculty/test_report';
  static const FACULTY_TEST_PAGE = '/faculty/test_page';
  static const FACULTY_POST_TEST_PAGE = '/faculty/post_test_page';
  static const FACULTY_TEST_RESULT_QUESTION_PAGE = '/faculty/test_result_question_page';
  static const FACULTY_SINGLE_QUESTION_PAGE = '/faculty/single_question_page';
  static const FACULTY_TEST_RESULT_PAGE = '/faculty/test_result';

}