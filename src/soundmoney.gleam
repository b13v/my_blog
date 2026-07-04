import blogatto
import blogatto/error
import gleam/io
import soundmoney/config

pub fn main() {
  case blogatto.build(config.build_config()) {
    Ok(Nil) -> io.println("Site built successfully in ./dist")
    Error(err) -> {
      io.println("Build failed: " <> error.describe_error(err))
      panic as "Build failed"
    }
  }
}
