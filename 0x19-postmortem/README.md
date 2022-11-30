0x19. Postmortem
# Post mortem
![alt text](./reporting-2.png)

# Incident Report 
For Https://napsa.tech
Summary
From 11:40 GMT to 12:00 GMT, requests to Https://napsa.tech resulted in “Failed to connect to 0 port 80”. All applications that relied on these servers also returned errors and had reduced functionality. The issue affected 100% of traffic to the server. The root cause of this was an invalid configuration for the Nginx web server.

Timeline
11:40 GMT: Configuration push begins
11:42 GMT: Outage begins
11:42 GMT: Pager alerts teams
11:45 GMT: Failed configuration change rollback
11:50 GMT: Successful configuration change rollback
11:52 GMT: Server starts back online
12:00 GMT: 100% of traffic back online

Root Cause
At 11:40 GMT, a configuration change was immediately released to the production environment without being released to the testing environment. The change triggered a failure on restarting Nginx services in servers. This prevented all requests to the server to be properly handled. The internal monitoring system permanently blocked calls to the routes provided. The combination of bug and configuration errors quickly caused all services to fail. Traffic was permanently queued waiting for a serving thread to become available. The server began restarting and failed to start service and at 11:42 GMT the outage began.

Resolution
At 11:42 GMT, the monitoring systems alerted our engineers who investigated and quickly escalated the issue. By 11:45 GMT, the incident response team identified the monitoring system was exacerbating the problem caused by this bug.
At 11:45 GMT, we attempted to roll back the problematic configuration change. The rollback failed due to the complexity of the system. These problems were addressed and we successfully rolled back at 11:50 GMT

To help recovery, some monitoring systems were turned off which were triggered by the bug. As a result, servers were restarted gradually to avoid possible cascading features from a wide-scale restart. By 11:52 GMT 60% of traffic was restored and 100% of traffic was routed to servers on port 80

Corrective & Preventive measures
The following day, we conducted an internal review and analysis of the outage. We would be taking the following actions to address the underlying causes of the issue and help prevent recurrence and improve response times.

Disable the current configuration release mechanism until safer measures are implemented.
Change the rollback process to be quicker and more robust.
Fix underlying bugs and monitor to correctly timeout or interrupt errors.
Improve the process for auditing all high-risk configurations
Develop a faster mechanism and improve the traffic ramp-up process so any future problems can be corrected quickly.

