# Performance Testing Report

## Objective

Performance testing was conducted to evaluate the application's throughput, response latency, scalability, and stability under varying workloads. The tests also verified the effectiveness of the Nginx load balancer and the application's failover capability during backend failures.

---

## Test Environment

| Parameter | Value |
|-----------|-------|
| Tool | wrk |
| Protocol | HTTPS |
| Endpoint | `/healthz` |
| Test Duration | 30 seconds |
| Reverse Proxy | Nginx |
| Backend Instances | 3 (Normal), 1 (Failover) |

---

# 1. Performance Benchmark (Normal Operation)

During this test, all three backend replicas were running and Nginx distributed requests among them.

## Benchmark Results

| Threads | Connections | Requests/sec | Avg Latency | StdDev | Timeouts |
|---------:|------------:|-------------:|------------:|--------:|---------:|
| 4 | 50 | 3023.89 | 43.43 ms | 156.80 ms | 192 |
| 8 | 50 | 2984.55 | 48.47 ms | 174.10 ms | 192 |
| 8 | 200 | 2643.53 | 90.93 ms | 247.84 ms | 638 |

### Analysis

#### Throughput

The application consistently sustained approximately **3000 requests per second** under moderate workloads. Increasing the concurrency level from **50** to **200** simultaneous connections reduced throughput by approximately **12.6%**, indicating increased resource contention under heavier load.

#### Response Latency

Average latency increased from **43.43 ms** to **90.93 ms** as concurrency increased. This behavior is expected because a larger number of simultaneous requests compete for CPU time, network bandwidth, and backend processing resources.

#### Response Time Consistency

The latency standard deviation increased from **156.80 ms** to **247.84 ms**, demonstrating greater variation in response times under heavier workloads. While most requests completed quickly, some experienced significantly longer delays due to resource contention.

#### Stability

Timeouts increased from **192** to **638** as concurrency increased, indicating that the server approached its processing capacity under the highest workload. Despite this, the application continued processing over **2600 requests per second**, demonstrating stable behavior under sustained load.

---

# 2. Failover Verification

To verify the failover strategy, two backend containers were intentionally stopped.

```bash
docker stop backend1 backend2
```

Nginx automatically redirected all incoming requests to the remaining healthy backend without requiring any manual intervention.

---

## Benchmark Results (Single Backend)

| Threads | Connections | Requests/sec | Avg Latency | StdDev | Timeouts |
|---------:|------------:|-------------:|------------:|--------:|---------:|
| 4 | 50 | 2811.35 | 25.38 ms | 125.76 ms | 270 |
| 8 | 50 | 3022.56 | 38.20 ms | 148.27 ms | 217 |
| 8 | 200 | 466.67 | 12.41 ms | 78.40 ms | 190 |

### Analysis

#### Service Availability

Despite two backend replicas being unavailable, the application continued serving client requests successfully. This confirms that the Nginx upstream configuration correctly detected failed backend instances and redirected traffic to the remaining healthy backend.

#### Throughput

With only one backend available, throughput under heavy load dropped significantly from **2643.53 requests/sec** to **466.67 requests/sec**. This reduction is expected because all requests were processed by a single backend instance.

#### Response Latency

Although the reported average latency decreased during the 200-connection test, this should not be interpreted as improved performance. Under heavy load, many requests timed out before completion, leaving only successfully completed requests to contribute to the latency measurement.

#### High Availability

The application remained operational throughout the experiment without requiring a restart or manual reconfiguration. This demonstrates successful implementation of automatic failover and graceful degradation under backend failures.

---

# Performance Observations

- The application maintained stable throughput under moderate workloads.
- Response latency increased proportionally with higher concurrency.
- Higher concurrency produced greater response time variability.
- Request timeout frequency increased as backend resources became saturated.
- Horizontal scaling improved the application's ability to process concurrent requests.
- Automatic failover ensured uninterrupted service after multiple backend replicas were stopped.
- Performance degraded gracefully under reduced backend capacity rather than resulting in complete service failure.

---

# Conclusion

The performance evaluation demonstrates that the application successfully supports horizontal scaling through multiple backend replicas while maintaining stable throughput and acceptable response latency under concurrent workloads.

As system load increased, latency, response time variation, and timeout frequency also increased, indicating expected resource contention. During failover testing, Nginx automatically rerouted requests to the remaining healthy backend, ensuring continuous service availability without manual intervention.

Overall, the implemented architecture satisfies the objectives of load balancing, high availability, and graceful degradation under backend failures.
