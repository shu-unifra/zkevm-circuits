// mod integration_tests::integration_test_circuits;

use integration_tests::{integration_test_circuits::*, log_init};
use std::env;
#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    log_init();

    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        log::error!("use runner <block_number>");
    }

    let block_num: u64 = args[1].parse().expect("Failed to parse");
    let c_name = args[2].clone();

    macro_rules! my_rules {
      ($($c_name:ident),+) => {
          $(
              if stringify!($c_name) == c_name {
                  log::info!("running {}",c_name);
                  let mut test = $c_name.lock().await;
                  test.test_at_block_tag2(block_num, true).await;
              }
          )+
      };
  }
    my_rules!(
        EVM_CIRCUIT_TEST,
        STATE_CIRCUIT_TEST,
        TX_CIRCUIT_TEST,
        BYTECODE_CIRCUIT_TEST,
        COPY_CIRCUIT_TEST,
        KECCAK_CIRCUIT_TEST,
        SUPER_CIRCUIT_TEST,
        EXP_CIRCUIT_TEST
    );

    Ok(())
}
