db = db.getSiblingDB('ratings');

cursor = db.highlightedProfile.find({ "siteId" : id }, {"filename" :1});

while (cursor.hasNext())
{
    printjsononeline(cursor.next());
}