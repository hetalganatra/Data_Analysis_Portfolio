## AI Event Analysis Agent (n8n + OpenAI)

An AI-powered workflow that automatically analyzes concert event performance data and generates insights about revenue, ticket sales, and event types.
The workflow uses n8n orchestration, OpenAI language models, and Google Sheets integration to automate event analytics and reporting.

## Project Overview

This project demonstrates how an AI agent can automate event performance analysis. The workflow retrieves event data from Google Sheets, processes the data using an OpenAI model, and generates insights about event performance trends.

The AI agent identifies patterns such as:

Best performing event types

Revenue trends across events

Average tickets sold

Audience preferences

The generated insights are automatically stored in Google Sheets for reporting and further analysis.

## Workflow Architecture

### Chat Trigger

- The workflow starts when a chat message is received.

### Event Analysis Agent

- Processes the request and orchestrates the analysis workflow.

### Get Concert Data

- Retrieves event dataset from Google Sheets.

### OpenAI Chat Model

- Analyzes the dataset and generates insights.

### Memory Component

- Stores context during workflow execution.

### AI Insight Output

- Generated insights are appended to a Google Sheet for tracking and reporting.

## Example Insights Generated

The AI agent analyzes event data and produces insights such as:

- **Original events** generate the highest total revenue.
- **Cover events** attract moderate ticket sales.
- **Mixed events** combine audiences and generate balanced revenue.
- Higher ticket sales correlate with certain **event types and audience preferences**.

## Tech Stack

- **n8n** – Workflow orchestration  
- **OpenAI GPT Model** – AI-powered analysis  
- **Google Sheets API** – Data storage and retrieval  
- **AI Agent Workflow Automation**

## How to Use This Workflow

1. Install **n8n**
2. Import the workflow JSON file
3. Configure the following credentials:
   - OpenAI API key
   - Google Sheets connection
4. Run the workflow
5. Send a chat message to trigger event analysis

The AI agent will analyze the dataset and generate insights automatically.

## Use Cases

This AI workflow can be applied to:

- Event performance analytics
- Ticket sales analysis
- Automated event reporting
- AI-powered business insights
- Data-driven decision support

## Workflow Architecture

<img width="1676" height="803" alt="EventAnalysisAgentWorkflow_Screenshot" src="https://github.com/user-attachments/assets/6937ebbb-fede-4716-b12e-4ece62049ad9" />
