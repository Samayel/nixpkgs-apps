final: prev:
{
  # this key should be the same as the flake name attribute.
  hello-flake = {
    hello = prev.hello;
  };
}
