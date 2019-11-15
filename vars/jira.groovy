def call(){
 def request = libraryResource 'data.json'
 createIssues(request)
}