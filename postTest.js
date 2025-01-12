async function runTest(METHOD, link, payload) {
  try {
    const response = await fetch(link, {
      method: METHOD,
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(payload),
    });
    const result = await response.json();
    if (response.ok) {
      console.log(JSON.stringify(result));
    } else {
      console.log(JSON.stringify(result));
    }
  } catch (error) {
    console.log("Request failed: " + error.message);
  }
}

// eslint-disable-next-line no-unused-vars
const b = {
  session_id: "ab",
  new_semester_id: "2099/2012-3",
  semester_id: "2099/3212-2",
  category_name: "PSM 414",
  new_category_name: "KUCING",
  username: "12085",
  password: "S808323",
  username1: "A16CS4016",
  password1: "201608M10112",
};

const host = "http://localhost:80";
let METHOD = "post";
const crud = "/";
const type = "deleteLinkPermission";

// ONLY for GET method, can leave this alone if POST
const PARAMTYPE = "?semester_id";
const PARAMVALUE = "=2024/2025-1";

const payload = {
  session_id: "qw",

  semester_id: "2024/2025-2",
  category_name: "PSM 1",

  new_semester_id: "2099/2012-3",
  new_category_name: "PSM 1",
  // username : "12085",
  // password : "S808323",
  username: "johnAcad",
  password: "johnAcad",

  ref_name: "History Black Catto",
  desc: "The detailed untold history",
  link: "google.com",

  gdlink_id: "84",
  new_ref_name: "white cat",
  new_desc: "orange cat ",
  new_link: "whatss.com",

  selected_user_role: "Pensyarah",
  // selected_user_email :  'johnStu@utm.cm' ,

  insert_user_role: "Pensyarah",
  insert_user_email: "johnStu@utm.com",

  can_read_category: "true",
  can_create_links: "true",

  can_read: 1,
  can_update: 0,
  can_delete: 1,
};

const endpoint = crud + type;
let link = host + endpoint;

if (METHOD == "GET" || METHOD == "get") {
  link += PARAMTYPE + PARAMVALUE;
  runTest(METHOD, link);
} else runTest(METHOD, link, payload);
