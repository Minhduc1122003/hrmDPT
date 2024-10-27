const String serverURL = 'http://api-rms.reetech.vn';

// const String loginAPI = 'http://uat-hrm.reecorp.vn/erp/Users/weblogin';
// Link api-rms.reetech.vn
const String loginAPI = '$serverURL/api/Users/loginv1';
const String loginAPI1 = 'http://localhost:3000/user/login';

const String getListUserUri = '$serverURL/api/Users';

const int statusOk = 200;
const int statusCreated = 201;
const int statusAccepted = 202;
const int statusBadRequest = 400;
const int statusNotAuthorized = 403;
const int statusNotfound = 404;
const int statusInternalError = 500;
