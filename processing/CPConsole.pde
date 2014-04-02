int cpConsole(String msg){
  if(javascript!=null){
    javascript.logToConsole(msg);
    return 0;
  } else {
   println(msg); 
return 1;  
}
  
}
