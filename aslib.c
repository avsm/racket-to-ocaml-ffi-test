#include <stdio.h>
#include <caml/mlvalues.h>
#include <caml/callback.h>

__attribute__ ((__constructor__))
void init(void) {
  char *caml_argv[1] = { NULL };
  caml_startup(caml_argv);
}

int call_caml_doubler(int arg)
{
  value cb;
  cb = caml_callback(*caml_named_value("doubler"), Val_int(arg));
  return Int_val(cb);
}

int double_int(int a) {
  return call_caml_doubler(a);
}
