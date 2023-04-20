// mod integration_tests::integration_test_circuits;

use integration_tests::{integration_test_circuits::*, log_init};

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    log_init();
    {
        let mut test = SUPER_CIRCUIT_TEST.lock().await;
        test.test_at_block_tag2(0x1, true).await;
    }
    // {
    //     let mut test = EVM_CIRCUIT_TEST.lock().await;
    //     test.test_at_block_tag("Transfer 0", true).await;
    // }
    {
        let mut test = BYTECODE_CIRCUIT_TEST.lock().await;
        test.test_at_block_tag2(0x1, true).await;
    }

    Ok(())
}
