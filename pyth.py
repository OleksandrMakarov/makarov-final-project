import sys
import json


json_var = {"_class":"com.cloudbees.plugins.credentials.CredentialsStoreAction$DomainWrapper","credentials":[{"id":"d446f82f-8959-409e-ab73-a9325e2e7a9f"},{"id":"670921d2-bc40-4605-9ea3-eef1982effaa"}]}
# print(json.loads(json_var))
print(json_var["credentials"][0]['id'])