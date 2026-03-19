🧱 System Architecture Overview

This project deploys a two-tier web application (WordPress + MySQL) on AWS using Docker containers running on an EC2 instance.
🔗 Architecture Flow

User → EC2 Instance → Docker → WordPress Container → MySQL Container → EBS Volume

* Users access the application through a browser using the EC2 public IP.
* The EC2 instance hosts Docker, which runs both WordPress and MySQL containers.
* WordPress handles the web interface and communicates with the MySQL database.
* The MySQL container stores its data on an attached EBS volume to ensure persistence.

💾 Why EBS Volume Was Used
An EBS (Elastic Block Store) volume is used to store MySQL data instead of storing it inside the container.
Reason:
* Data inside a container is lost when that container is stopped or removed
* Without EBS, all database data would be lost if the container crashes or is recreated.
But when we use an EBS
* Data is stored independently of the container lifecycle.
* Even if the container stops or the EC2 instance restarts, the data remains intact.

🔐 Security Group Configuration
The following ports were opened:
* Port 22 (SSH) → Allows secure remote access to the EC2 instance.
* Port 80 (HTTP) → Allows users to access the WordPress website via a browser.
Security Risks:
* Opening port 22 to 0.0.0.0/0 exposes SSH to the entire internet, which increases risk of brute-force attacks.[From the direction of the first part of this assignment, I just used 0.0.0.0/0 still, because I experienced issues in the previous project and didn’t want the same here.]
* Opening port 80 to 0.0.0.0/0 is necessary for web access but exposes the application publicly.

💥 What Happens if the EC2 Instance Crashes
What is LOST:
* The running containers (WordPress and MySQL processes)
* Any data stored inside the container filesystem
What is PRESERVED:
* Data stored in the EBS volume (MySQL database data)
* Backups stored in the S3 bucket
* Docker images (if cached or pulled again)

📈 Scaling Considerations (100x Users)

For a hundred x more users, I honestly don’t know the changes I’ll make to improve this, but I’m sure I’ll figure that out in the next few sessions.

