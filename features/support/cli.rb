require 'open3'

def run_cmd(cmd)
  puts "Running: #{cmd}\n"

  @output = ""
  exit_status = 0
  Open3.popen2e(cmd) do |input, output_and_error, wait_thread|
    output_and_error.each do |line|
      @output << "\n" + line
      STDOUT.puts line
      STDOUT.flush
    end
    exit_status = wait_thread.value
  end

  assert exit_status.success?, "Process exited with non-zero exit status: #{exit_status}\nTry running the previous command manually to inspect the output.\n\n"
  puts "Process exited successfully"
end
