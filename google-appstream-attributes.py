from __future__ import print_function
import pickle
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

# If modifying these scopes, delete the file token.pickle.
SCOPES = ['https://www.googleapis.com/auth/admin.directory.user']

def get_credentials():
    """Shows basic usage of the Admin SDK Directory API.
    Prints the emails and names of the first 10 users in the domain.
    """
    creds = None
    # The file token.pickle stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists('token.pickle'):
        with open('token.pickle', 'rb') as token:
            creds = pickle.load(token)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                'credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)

    return creds

def  update_saml_attributes(service, user):
    custom_schema = {
        "SessionDuration": "3600",
        "FederationRole": "arn:aws:iam::404878421572:role/SNCGoogle,arn:aws:iam::404878421572:saml-provider/GoogleSSO"
        }
        
    user.update({'customSchemas' : {'Appstream' : custom_schema}})
    ret = service.users().update(userKey=user['id'], body=user).execute()
    
    return ret['customSchemas']

def main():

    creds = get_credentials()

    service = build('admin', 'directory_v1', credentials=creds)

    # Call the Admin SDK Directory API
    # print('Getting the first 10 users in the domain')
    # The use of single quotes on the orgPath parameter allows OU paths with spaces
    orgPath = "orgUnitPath='/'"

    aNextPageToken = "one"
    aPageToken = "0a31f7fee5589affffffff91969c90939ad1999a96919a8dbf8c919cd19a9b8aff00fefffec6c9ccc7cccacfc7c8cacbc8fffe10904e21b346550b02f34e66390000000065a71a01487150005a0b092d80407ee6f34333100360b1d9ebd201720608a49bce8006"

    while aNextPageToken :
        results = service.users().list(customer='my_customer', 
            query=orgPath, 
            pageToken=aPageToken,
            # comment out maxResults to make changes to more than the first 10 users. This is currently set to limit errors affecting more than 10 users until you've tested the script
            maxResults=500, 
            orderBy='email').execute()
        users = results.get('users', [])

        if not users:
            print('No users in the domain.')
        else:
            print('Updated users with the following customSchemas')
            for user in users:
                # Uncomment the following line to print users for confirmation/testing
                # print(u'{0} ({1})'.format(user['primaryEmail'], user['name']['fullName']))

                # The following will update the user customSchemas - comment out if you're only testing
                userUpdated = update_saml_attributes(service, user)
                print(u'{0} {1} {2}'.format(user['primaryEmail'], user['id'], userUpdated))
        print('Finished page token:', aPageToken)
        aNextPageToken =  None
        if 'nextPageToken' in results :
            aPageToken = results['nextPageToken']
            aNextPageToken = results['nextPageToken']
            print('Next page token:', aNextPageToken)



if __name__ == '__main__':
    main()
