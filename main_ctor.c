#include <stdio.h>
#include <caml/mlvalues.h>
#include <caml/callback.h>

int call_caml_doubler(int arg)
{
  value cb;
  cb = caml_callback(*caml_named_value("doubler"), Val_int(arg));
  return Int_val(cb);
}

__attribute__ ((__constructor__))
void init(void) {
  char *caml_argv[1] = { NULL };
  caml_startup(caml_argv);
}

int main(int argc, char **argv)
{
  fprintf(stderr, "%d\n", call_caml_doubler(5));
  fprintf(stderr, "%d\n", call_caml_doubler(100));
  fprintf(stderr, "%d\n", call_caml_doubler(25000));
  return 0;
}
