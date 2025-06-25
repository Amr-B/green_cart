const fs = require('fs');
const path = require('path');

const profilesFile = path.join(__dirname, 'profiles.json');

function readProfiles() {
    if (!fs.existsSync(profilesFile)) fs.writeFileSync(profilesFile, '[]');
    const data = fs.readFileSync(profilesFile, 'utf8');
    return data ? JSON.parse(data) : [];
}

function writeProfiles(profiles) {
    fs.writeFileSync(profilesFile, JSON.stringify(profiles, null, 2));
}

function addProfile({ id, name, email, image }) {
    const profiles = readProfiles();
    profiles.push({ id, name, email, image });
    writeProfiles(profiles);
}

module.exports = { readProfiles, addProfile };
