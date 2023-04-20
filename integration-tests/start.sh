
cargo build -r --features scroll
export LD_LIBRARY_PATH="/home/shu/zkevm-circuits/target/release/build/zktrie-b0cdbb4b9a38d355/out/:$LD_LIBRARY_PATH"
export GETH0_URL="http://10.2.0.208:8545" #scroll-node-alpha-1

for ((i=30; i<31; i++)); do
  echo $(date)  $i
  echo $(date)  EVM_CIRCUIT_TEST...
  RUST_BACKTRACE=full ../target/release/runner ${i} EVM_CIRCUIT_TEST       >${i}_EVM_CIRCUIT_TEST.log 2>&1 
  echo $(date)  STATE_CIRCUIT_TEST...
  RUST_BACKTRACE=full ../target/release/runner ${i} STATE_CIRCUIT_TEST     >${i}_STATE_CIRCUIT_TEST.log 2>&1 
  echo $(date)  TX_CIRCUIT_TEST...
  RUST_BACKTRACE=full ../target/release/runner ${i} TX_CIRCUIT_TEST        >${i}_TX_CIRCUIT_TEST.log 2>&1 
  echo $(date)  BYTECODE_CIRCUIT_TEST
  RUST_BACKTRACE=full ../target/release/runner ${i} BYTECODE_CIRCUIT_TEST  >${i}_BYTECODE_CIRCUIT_TEST.log 2>&1 

  echo $(date)  COPY_CIRCUIT_TEST...
  RUST_BACKTRACE=full ../target/release/runner ${i} COPY_CIRCUIT_TEST      >${i}_COPY_CIRCUIT_TEST.log 2>&1 
  echo $(date)  KECCAK_CIRCUIT_TEST...
  RUST_BACKTRACE=full ../target/release/runner ${i} KECCAK_CIRCUIT_TEST    >${i}_KECCAK_CIRCUIT_TEST.log 2>&1 
  echo $(date)  SUPER_CIRCUIT_TEST...
  RUST_BACKTRACE=full ../target/release/runner ${i} SUPER_CIRCUIT_TEST     >${i}_SUPER_CIRCUIT_TEST.log 2>&1 
  echo $(date)  EXP_CIRCUIT_TES...
  RUST_BACKTRACE=full ../target/release/runner ${i} EXP_CIRCUIT_TES        >${i}_EXP_CIRCUIT_TEST.log 2>&1 
done
