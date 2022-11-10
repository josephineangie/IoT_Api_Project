from flask import Flask, jsonify, request
from flask_restful import Api, Resource, abort
from flask_mysqldb import MySQL
from datetime import datetime

app = Flask(__name__)
api = Api(app)

app.config['MYSQL_HOST'] = '127.0.0.1'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'iotweb'
app.config['MYSQL_USE_UNICODE'] = True

mysql = MySQL(app)


class userActivity(Resource): 
    def getUserById(self,idCard): #function to get spesified idCard activity
        query = f"SELECT * FROM userActivity WHERE idCard='{idCard}'"
        cursor = mysql.connection.cursor() #connect to the database
        cursor.execute(query) #exeute the database
        data = cursor.fetchall()
        return data
    
    def getAllUser(self): #function to get all user activity
        query = "SELECT * FROM useractivity"
        cursor = mysql.connection.cursor() #connect to the database
        cursor.execute(query)
        data = cursor.fetchall()
        return data
    
    def convertToDict(self,row): #function to convert object to dictionary
        dictData = dict()
        dictData["idActivity"] = row[0]
        dictData["idCardReader"] = row[1]
        dictData["idCard"] = row[2]
        dictData["waktu"] = row[3]
        dictData["statusAktivitas"] = row[4]
        return dictData
    
    def get(self,idCard=None,time=None,year=None):
        dt = request.args.get("date")
        dy = request.args.get("day")
        mn = request.args.get("month")
        idCard = request.args.get("idCard")
        status = request.args.get("status")
        
        # valid date,day, and month
        date = ["01","02","03","04","05","06","07","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
        day = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
        month = ["Jan","Feb","Mar","Apr","Mei","Jun","Jul","Aug","Sep","Oct","Nov","Des"]
        
        # if user want to search all user activity
        if idCard == None and dt == None and dy == None and mn == None and status == None:
            data = self.getAllUser()
            allData = []
            for row in data:
                dictData = self.convertToDict(row)
                allData.append(dictData) 
            return jsonify(allData)
        # if user want search only by idCard
        elif idCard !=None and dt == None and dy == None and mn == None and status == None:
            data = self.getUserById(idCard)
            allData = []
            if data: #cek jika terdapat data yang dicari
                for row in data:
                    dictData = self.convertToDict(row)
                    allData.append(dictData) 
                return jsonify(allData)
            else:
                abort(404,message="The Data You Looking For Does'nt Exist",stauts=404)
        # if user want search spesified idCard and on the month he/she entered the room
        elif idCard != None and dt == None and dy == None and mn != None and status == None:
            if mn in month:
                data = self.getUserById(idCard)
                allData = []
                if data: #cek jika terdapat data yang dicari
                    for row in data:
                        checkMt = row[3].strftime("%b")
                        if checkMt == mn:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                    if allData: #cek jika terdapat data yang dicari
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Does'nt Exist",stauts=404)
                else:
                    abort(404,message="The Data You Looking For Does'nt Exist",stauts=404)
            else:
                abort(404,message="The Data You Looking For Does'nt Exist",stauts=404)
        # if user want search spesified idCard and on the date he/she entered the room
        elif idCard != None and dt != None and dy == None and mn == None and status == None:
            if dt in date:
                data = self.getUserById(idCard)
                allData = []
                if data : #cek jika terdapat data yang dicari
                    for row in data:
                        checkDt = row[3].strftime("%d")
                        if checkDt == dt:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                    if allData: #cek jika terdapat data yang dicari
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Does'nt Exist",stauts=404)
                else:
                    abort(404,message="The Data You Looking For Does'nt Exist",stauts=404)
            else:
                abort(404,message="The Data You Looking For Does'nt Exist",stauts=404)
        # if user want search spesified idCard and on the day he/she entered the room (dedi)
        elif idCard != None and dt == None and dy != None and mn == None and status == None:
            if dy in day:
                data = self.getUserById(idCard)
                allData = []
                if data : #cek jika terdapat data yang dicari
                    for row in data:
                        checkDy = row[3].strftime("%a")
                        if checkDy == dy:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                    if allData: #cek jika terdapat data yang dicari
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                else:
                    abort(404,message="The Data You Looking For Doesn't Exist",status=404)
            else:
                abort(404,message="The Data You Looking For Doesn't Exist",status=404)
        
        # if user want search spesified idCard and on the month and on the date he/she entered the room (Angie)
        elif idCard != None and dt != None and dy == None and mn != None and status == None:
            if dt in date:
                data = self.getUserById(idCard)
                allData = []
                if data : #cek jika terdapat data yang dicari
                    for row in data:
                        checkDt = row[3].strftime("%d")
                        if checkDt == dt:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                    if allData: #cek jika terdapat data yang dicari
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                else:
                    abort(404,message="The Data You Looking For Doesn't Exist",status=404)
            elif mn in month:
                data = self.getUserById(idCard)
                allData = []
                if data: #cek jika terdapat data yang dicari
                    for row in data:
                        checkMt = row[3].strftime("%b")
                        if checkMt == mn:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                    if allData: #cek jika terdapat data yang dicari
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                else:
                    abort(404,message="The Data You Looking For Doesn't Exist",status=404)
            else:
                abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                
        # if user want search spesified idCard and on the month and on the day he/she entered the room (Angie)
        elif idCard != None and dt == None and dy != None and mn != None and status == None:
            if dy in day:
                data = self.getUserById(idCard)
                allData = []
                if data : #cek jika terdapat data yang dicari
                    for row in data:
                        checkDy = row[3].strftime("%a")
                        if checkDy == dy:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                    if allData: #cek jika terdapat data yang dicari
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                else:
                    abort(404,message="The Data You Looking For Doesn't Exist",status=404)
            elif mn in month:
                data = self.getUserById(idCard)
                allData = []
                if data: #cek jika terdapat data yang dicari
                    for row in data:
                        checkMt = row[3].strftime("%b")
                        if checkMt == mn:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                    if allData: #cek jika terdapat data yang dicari
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                else:
                    abort(404,message="The Data You Looking For Doesn't Exist",status=404)
            else:
                abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                
        # if user want search all activity and on the month all people entered that room (Angie)
        elif idCard == None and dt == None and dy == None and mn != None and status == None:
            if mn in month:
                allData = []
                data = self.getAllUser()
                if data:
                    for row in data:
                        rowMonth = row[3].strftime("%b")
                        if rowMonth == mn:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                    if allData:
                        return jsonify(allData)
                    else:
                        abort(
                            404, message="The Data You Looking For Doesn't Exist", status=404)
                else:
                    abort(
                        404, message="The Data You Looking For Doesn't Exist", status=404)
            else:
                abort(404, message="The Data You Looking For Doesn't Exist", status=404)

        # if user want search all activity and on the date all people entered that room (Alya)

        # if user want search all activity and on the day all people entered that room (Alya)
        elif idCard == None and dt == None and dy != None and mn == None and status == None:
            if dy in day:
                allData = []
                data = self.getAllUser()
                if data:
                    for row in data:
                        rowDay = row[3].strftime("%a")

                        if rowDay == dy:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)

                    if allData:
                        return jsonify(allData)
                    else:
                        abort(
                            404, message="The Data You Looking For Doesn't Exist", status=404)
                else:
                    abort(
                        404, message="The Data You Looking For Doesn't Exist", status=404)
            else:
                abort(404, message="The Data You Looking For Doesn't Exist", status=404)
        
        # if user want search all activity and on the month and on the date all people entered that room (dedi)
        elif idCard == None and dt != None and dy == None and mn != None and status == None:
            if dt in date and mn in month:
                allData = []
                data = self.getAllUser()
                
                if data:
                    for row in data:
                        rowDate = row[3].strftime("%d")
                        rowMonth = row[3].strftime("%b")
                        
                        if rowDate == dt and rowMonth == mn:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                        
                    if allData:
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                else:
                    abort(404,message="The Data You Looking For Doesn't Exist",status=404)
            else:
                abort(404,message="The Data You Looking For Doesn't Exist",status=404)
        
        # if user want search all activity and on the month and on the day all people entered that room (dedi)
        elif idCard == None and dt == None and dy != None and mn != None and status == None:
            if dy in day and mn in month:
                allData = []
                data = self.getAllUser()
                
                if data:
                    for row in data:
                        rowDay = row[3].strftime("%a")
                        rowMonth = row[3].strftime("%b")
                        
                        if rowDay == dy and rowMonth == mn:
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                        
                    if allData:
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                else:
                    abort(404,message="The Data You Looking For Doesn't Exist",status=404)
            else:
                abort(404,message="The Data You Looking For Doesn't Exist",status=404)
        
        # if user want search all activity that check in that room(dedi)
        elif idCard == None and dt == None and dy == None and mn == None and status != None:
            if status.lower() == "masuk":
                allData = []
                data = self.getAllUser()
                
                if data:
                    for row in data:
                        rowStatus = row[4]
                        if rowStatus.lower() == "masuk":
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                    if allData:
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                else:
                    abort(404,message="The Data You Looking For Doesn't Exist",status=404)
            else:
                abort(404,message="The Data You Looking For Doesn't Exist",status=404)
        
        # if user want search all activity that check out that room (dedi)
        elif idCard == None and dt == None and dy == None and mn == None and status != None:
            if status.lower() == "keluar":
                allData = []
                data = self.getAllUser()
                
                if data:
                    for row in data:
                        rowStatus = row[4]
                        if rowStatus.lower() == "keluar":
                            dictData = self.convertToDict(row)
                            allData.append(dictData)
                    if allData:
                        return jsonify(allData)
                    else:
                        abort(404,message="The Data You Looking For Doesn't Exist",status=404)
                else:
                    abort(404,message="The Data You Looking For Doesn't Exist",status=404)
            else:
                abort(404,message="The Data You Looking For Doesn't Exist",status=404)
        

                
    def post(self): #insert userActivity to table userActivity
        idActivity = ""
        idCardReader = request.form.get('idCardReader')
        idCard = request.form.get('idCard')
        waktu = request.form.get('waktu')
        status = request.form.get('statusAktivitas')
        
        if idCardReader == "" or idCard == "" or waktu == "" or status == "":
            abort(404,message="You Must Provide Value To All Fields",stauts=404)
        try:
            cursor = mysql.connection.cursor()
            cursor.execute("INSERT INTO useractivity (idActivity,idCardReader,idCard,waktu,statusAktivitas) VALUES (%s,%s,%s,%s,%s)",(idActivity,idCardReader,idCard,waktu,status))
            mysql.connection.commit()
            cursor.close()

            return jsonify({"message":"Data Success To Insert !!","status":201})
        except:
            abort(404,message="Data Failed To Insert",status=404)
            
# Route Resource Api
api.add_resource(userActivity, "/useractivity/",endpoint="/useractivity/")

if __name__ == '__main__':
    app.run(debug=True)
