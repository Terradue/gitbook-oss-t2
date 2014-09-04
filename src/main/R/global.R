
function GetRepos(organization) {

# get the data from GitHub
repos.json <- fromJSON(getURLContent(paste0("https://api.github.com/orgs/", github.organization, "/repos?per_page=1000"), ssl.verifypeer = FALSE, useragent = "R"))

project.name <- c()
project.fullname <- c()
project.description <- c()
project.lastupdate <- c()
project.creationdate <- c()
project.language <- c()
project.forks <- c()
project.stars <- c()
project.chapter <- c()


# create a dataframe with the repos

for(i in 1:length(repos.json)) {
  repo <- repos.json[[i]]
  
  if (repo$private == FALSE) {
    gitBook.filepath <- paste("https://raw.githubusercontent.com", repo$full_name, "master/.gitbook",sep="/")
    
    result <- try(chapter.json <- fromJSON(getURLContent(gitBook.filepath, ssl.verifypeer = FALSE, useragent = "R")));
    
    if (class(result) == "try-error") 
      next;
    
    # a repo can be part of more then one section
    for (j in 1:length(chapter.json)) {
      
      project.name <- append(project.name, repo$name)
      project.fullname <- append(project.fullname, repo$full_name)
      project.description <- append(project.description, repo$description)
      project.lastupdate <- append(project.lastupdate, repo$updated_at)
      project.creationdate  <- append(project.creationdate , repo$created_at)
      project.language <- append(project.language, ifelse(length(repo$language) > 0, repo$language, "")) 
      project.forks <- append(project.forks , repo$forks_count)
      project.stars <- append(project.stars , repo$stargazers_count)
      project.chapter <- append(project.chapter, chapter.json[[j]])  
     
      }
    }
  }


repo.frame <- data.frame(ProjectName=project.name, 
  Description=project.description, 
  ProgrammingLanguage=project.language,
  LastTimeUpdate=project.lastupdate,
  CreationTimeDate=project.creationdate, 
  Chapter=project.chapter,
  ProjectFullName=project.fullname,
  Forks=project.forks,
  Stars=project.stars,
  stringsAsFactors=FALSE)

return(repo.frame)

}
