const fs = require('fs');
const path = require('path');

const USERS_FILE = path.join(__dirname, 'users.json');

// لو الملف مش موجود، أنشئه فاضي
if (!fs.existsSync(USERS_FILE)) {
    fs.writeFileSync(USERS_FILE, JSON.stringify([]));
}

// قراءة المستخدمين
function readUsers() {
    const data = fs.readFileSync(USERS_FILE, 'utf-8');
    return JSON.parse(data);
}

// حفظ المستخدمين
function writeUsers(users) {
    fs.writeFileSync(USERS_FILE, JSON.stringify(users, null, 2));
}

module.exports = {
    readUsers,
    writeUsers,
};
