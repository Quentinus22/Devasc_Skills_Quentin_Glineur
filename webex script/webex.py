import requests 
import json 

access_token = "YTJlOTk1NjItMDI3MS00YTdiLTkwMGQtMTkwZmQ5NDE3MDU0ZjcyYTgxYjItYjFm_P0A1_14a2639d-5e4d-48b4-9757-f4b8a23372de"

groups_struc = {
 "groups": [
      { "group": { "group_id": "G1" , "group_name": "devasc_skills_Quentin_Glineur" ,    
                   "members": [   
                     {"person_id": "P-1" , "person_name": "Quentin", "email": "quentin.glineur@student.odisee.be"},
                     {"person_id": "P-2" , "person_name": "Yvan", "email": "yvan.rooseleer@biasc.be"}
                   ]
                 }
      }
   ]
}

url = 'https://api.ciscospark.com/v1/rooms'

headers = {'Authorization': 'Bearer {}'.format(access_token),'Content-Type': 'application/json' }
for rec in groups_struc["groups"]:
    create_group_name = rec["group"]["group_name"]
    print("Creating ... " + create_group_name)
    payload_space={"title": create_group_name}
    res_space = requests.post(url, headers=headers, json=payload_space)

    NEW_SPACE_ID = res_space.json()["id"]
    for mbr in rec["group"]["members"]:
        room_id = NEW_SPACE_ID
        person_email = mbr["email"] 
        url2 = 'https://api.ciscospark.com/v1/memberships'
        payload_member = {'roomId': room_id, 'personEmail': person_email}
        res_member = requests.post(url2, headers=headers, json=payload_member)

    url3 = 'https://api.ciscospark.com/v1/messages'
    message_text = 'Here are my screenshots of devasc skills-based exam'
    payload_message = {'roomId': room_id, 'text': message_text}
    res_message = requests.post(url3, headers=headers, json=payload_message)

    if res_message.status_code == 200:
        print('Message sent successfully!')
    else:
        print(f'Error sending message. Status code: {res_message.status_code}')
        print(res_message.text)