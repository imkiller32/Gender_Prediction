class Module {

  bool dartTheme;

  Module(this.dartTheme);

  void setTheme(darkTheme){
    this.dartTheme=darkTheme;
  }

  bool getTheme(){
    return this.dartTheme;
  }
}

Module module = Module(true);