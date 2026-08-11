<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-credit-card"></i> Credit Management History</h2>
                <a href="clientarea.php" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Client Area
                </a>
            </div>
            
            <!-- Date Filter Form -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-filter"></i> Filter Transactions</h5>
                </div>
                <div class="card-body">
                    <form method="GET" action="credits_history.php" class="row">
                        <div class="col-md-3">
                            <label for="filter">Quick Filter:</label>
                            <select name="filter" id="filter" class="form-control" onchange="toggleCustomDates()">
                                <option value="last7" {if $filterType == 'last7'}selected{/if}>Last 7 Days</option>
                                <option value="last30" {if $filterType == 'last30'}selected{/if}>Last 30 Days</option>
                                <option value="last90" {if $filterType == 'last90'}selected{/if}>Last 90 Days</option>
                                <option value="thismonth" {if $filterType == 'thismonth'}selected{/if}>This Month</option>
                                <option value="lastmonth" {if $filterType == 'lastmonth'}selected{/if}>Last Month</option>
                                <option value="custom" {if $filterType == 'custom'}selected{/if}>Custom Range</option>
                            </select>
                        </div>
                        <div class="col-md-3" id="startDateDiv" style="display: {if $filterType == 'custom'}block{else}none{/if};">
                            <label for="startdate">Start Date:</label>
                            <input type="date" name="startdate" id="startdate" class="form-control" value="{$startDate}">
                        </div>
                        <div class="col-md-3" id="endDateDiv" style="display: {if $filterType == 'custom'}block{else}none{/if};">
                            <label for="enddate">End Date:</label>
                            <input type="date" name="enddate" id="enddate" class="form-control" value="{$endDate}">
                        </div>
                        <div class="col-md-3">
                            <label>&nbsp;</label><br>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-search"></i> Filter
                            </button>
                            <a href="credits_history.php" class="btn btn-secondary">
                                <i class="fas fa-undo"></i> Reset
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Filter Info -->
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i> 
                <strong>Showing results from {$startDate|date_format:"%d %b %Y"} to {$endDate|date_format:"%d %b %Y"}</strong>
                {if $totalTransactions > 0}
                    - Found {$totalTransactions} transactions
                {else}
                    - No transactions found for this period
                {/if}
                <br><small class="text-muted">
                    <strong>Note:</strong> This page shows only transactions where credits from your account balance were used. 
                    Gateway payments (bKash, Uddoktapay, etc.) are not shown here.
                </small>
            </div>
            
            <!-- Statistics Cards (For Filtered Period) -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card bg-primary text-white">
                        <div class="card-body text-center">
                            <i class="fas fa-wallet fa-2x mb-2"></i>
                            <h5>{$currency->prefix}{$currentBalance|number_format:2}{$currency->suffix}</h5>
                            <small>Current Balance</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-success text-white">
                        <div class="card-body text-center">
                            <i class="fas fa-plus fa-2x mb-2"></i>
                            <h5>{$currency->prefix}{$totalCreditsAdded|number_format:2}{$currency->suffix}</h5>
                            <small>Credits Added (Period)</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-warning text-white">
                        <div class="card-body text-center">
                            <i class="fas fa-file-invoice-dollar fa-2x mb-2"></i>
                            <h5>{$currency->prefix}{$totalCreditsUsed|number_format:2}{$currency->suffix}</h5>
                            <small>Credits Used (Period)</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-info text-white">
                        <div class="card-body text-center">
                            <i class="fas fa-file-invoice fa-2x mb-2"></i>
                            <h5>{$invoicePaymentCount}</h5>
                            <small>Invoices Paid (Period)</small>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Credit Management Table -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">
                        <i class="fas fa-list"></i> Credit Management Log
                        <span class="badge badge-secondary ml-2">{$totalTransactions} Records</span>
                    </h5>
                </div>
                
                {if $transactions->count() > 0}
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0">
                                <thead class="thead-dark">
                                    <tr>
                                        <th style="width: 15%;">Date</th>
                                        <th style="width: 40%;">Description</th>
                                        <th style="width: 15%;" class="text-right">Amount</th>
                                        <th style="width: 15%;" class="text-center">Admin</th>
                                        <th style="width: 15%;" class="text-center">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $transactions as $transaction}
                                    <tr class="{if $transaction->type == 'credit_addition'}table-success{elseif $transaction->type == 'credit_payment'}table-warning{/if}">
                                        <td>
                                            <strong>{$transaction->date|date_format:"%d/%m/%Y"}</strong><br>
                                            <small class="text-muted">{$transaction->date|date_format:"%I:%M %p"}</small>
                                        </td>
                                        <td>
                                            <div>
                                                {if $transaction->type == 'credit_addition'}
                                                    <i class="fas fa-plus-circle text-success"></i>
                                                    <strong class="text-success">Credit Added to Account</strong>
                                                    <br>{$transaction->description}
                                                    
                                                    {if $transaction->transaction_id}
                                                        <br><small class="text-info">
                                                            <i class="fas fa-receipt"></i> Transaction ID: {$transaction->transaction_id}
                                                        </small>
                                                    {/if}
                                                    
                                                    <br><small class="text-muted">
                                                        <i class="fas fa-user-shield"></i> Added by: {$transaction->admin}
                                                    </small>
                                                    
                                                {elseif $transaction->type == 'credit_payment'}
                                                    <i class="fas fa-file-invoice text-warning"></i>
                                                    <strong class="text-warning">Invoice Paid with Credit</strong>
                                                    <br>{$transaction->description}
                                                    
                                                    {if $transaction->invoice_id}
                                                        <br><small class="text-primary">
                                                            <a href="viewinvoice.php?id={$transaction->invoice_id}">
                                                                <i class="fas fa-external-link-alt"></i> Invoice #{$transaction->invoice_id}
                                                            </a>
                                                        </small>
                                                    {/if}
                                                {/if}
                                            </div>
                                        </td>
                                        <td class="text-right">
                                            {if $transaction->amount > 0}
                                                <strong class="h6">
                                                    {if $transaction->type == 'credit_addition'}
                                                        <span class="text-success">
                                                            <i class="fas fa-plus"></i>
                                                            {$currency->prefix}{$transaction->amount|number_format:2}{$currency->suffix}
                                                        </span>
                                                    {else}
                                                        <span class="text-danger">
                                                            <i class="fas fa-minus"></i>
                                                            {$currency->prefix}{$transaction->amount|number_format:2}{$currency->suffix}
                                                        </span>
                                                    {/if}
                                                </strong>
                                            {else}
                                                <span class="text-muted">-</span>
                                            {/if}
                                        </td>
                                        <td class="text-center">
                                            {if $transaction->admin && $transaction->admin != ''}
                                                <span class="badge badge-secondary">{$transaction->admin}</span>
                                            {else}
                                                <span class="text-muted">System</span>
                                            {/if}
                                        </td>
                                        <td class="text-center">
                                            {if $transaction->invoice_id}
                                                <a href="viewinvoice.php?id={$transaction->invoice_id}" 
                                                   class="btn btn-sm btn-outline-primary" 
                                                   title="View Invoice">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                            {else}
                                                <span class="text-muted">-</span>
                                            {/if}
                                        </td>
                                    </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- Pagination with Filter Params -->
                    {if $totalPages > 1}
                    <div class="card-footer">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <small class="text-muted">
                                    Showing {($currentPage-1)*20 + 1} to 
                                    {if $currentPage*20 > $totalTransactions}{$totalTransactions}{else}{$currentPage*20}{/if} 
                                    of {$totalTransactions} records
                                </small>
                            </div>
                            <nav>
                                <ul class="pagination pagination-sm mb-0">
                                    {if $currentPage > 1}
                                        <li class="page-item">
                                            <a class="page-link" href="?page=1&filter={$filterType}&startdate={$startDate}&enddate={$endDate}">
                                                <i class="fas fa-angle-double-left"></i>
                                            </a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="?page={$currentPage-1}&filter={$filterType}&startdate={$startDate}&enddate={$endDate}">
                                                <i class="fas fa-angle-left"></i>
                                            </a>
                                        </li>
                                    {/if}
                                    
                                    {for $i=max(1, $currentPage-2) to min($totalPages, $currentPage+2)}
                                        <li class="page-item {if $i == $currentPage}active{/if}">
                                            <a class="page-link" href="?page={$i}&filter={$filterType}&startdate={$startDate}&enddate={$endDate}">{$i}</a>
                                        </li>
                                    {/for}
                                    
                                    {if $currentPage < $totalPages}
                                        <li class="page-item">
                                            <a class="page-link" href="?page={$currentPage+1}&filter={$filterType}&startdate={$startDate}&enddate={$endDate}">
                                                <i class="fas fa-angle-right"></i>
                                            </a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="?page={$totalPages}&filter={$filterType}&startdate={$startDate}&enddate={$endDate}">
                                                <i class="fas fa-angle-double-right"></i>
                                            </a>
                                        </li>
                                    {/if}
                                </ul>
                            </nav>
                        </div>
                    </div>
                    {/if}
                {else}
                    <div class="card-body text-center py-5">
                        <div class="mb-4">
                            <i class="fas fa-search fa-4x text-muted"></i>
                        </div>
                        <h4 class="text-muted">No Credit History Found</h4>
                        <p class="text-muted mb-4">
                            No credit transactions found for the selected date range.<br>
                            Try selecting a different date range or period.
                        </p>
                        <a href="?filter=last90" class="btn btn-info">
                            <i class="fas fa-calendar"></i> View Last 90 Days
                        </a>
                    </div>
                {/if}
            </div>
            
            <!-- Quick Actions -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <a href="clientarea.php?action=addfunds" class="btn btn-success btn-lg btn-block">
                        <i class="fas fa-plus"></i> Add More Credits
                    </a>
                </div>
                <div class="col-md-6">
                    <a href="clientarea.php?action=invoices" class="btn btn-primary btn-lg btn-block">
                        <i class="fas fa-file-invoice"></i> View All Invoices
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Enhanced JavaScript for Date Filter -->
<script>
function toggleCustomDates() {
    var filter = document.getElementById('filter').value;
    var startDiv = document.getElementById('startDateDiv');
    var endDiv = document.getElementById('endDateDiv');
    
    if (filter === 'custom') {
        startDiv.style.display = 'block';
        endDiv.style.display = 'block';
    } else {
        startDiv.style.display = 'none';
        endDiv.style.display = 'none';
    }
}

// Enhanced auto submit with date clearing
document.getElementById('filter').addEventListener('change', function() {
    if (this.value !== 'custom') {
        // Clear existing date inputs for non-custom filters
        document.getElementById('startdate').value = '';
        document.getElementById('enddate').value = '';
        this.form.submit();
    }
});

// Set max date to today for date inputs
document.addEventListener('DOMContentLoaded', function() {
    var today = new Date().toISOString().split('T')[0];
    document.getElementById('startdate').max = today;
    document.getElementById('enddate').max = today;
    
    // Initialize display based on current filter
    toggleCustomDates();
});

// Date validation
document.getElementById('startdate').addEventListener('change', function() {
    var startDate = new Date(this.value);
    var endDateInput = document.getElementById('enddate');
    var endDate = new Date(endDateInput.value);
    
    if (endDateInput.value && startDate > endDate) {
        alert('Start date cannot be later than end date');
        this.value = '';
    }
});

document.getElementById('enddate').addEventListener('change', function() {
    var endDate = new Date(this.value);
    var startDateInput = document.getElementById('startdate');
    var startDate = new Date(startDateInput.value);
    
    if (startDateInput.value && endDate < startDate) {
        alert('End date cannot be earlier than start date');
        this.value = '';
    }
});
</script>

<style>
.table-success {
    background-color: rgba(40, 167, 69, 0.1) !important;
}
.table-warning {
    background-color: rgba(255, 193, 7, 0.1) !important;
}
.card {
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    border: 1px solid rgba(0, 0, 0, 0.125);
}
.form-control:focus {
    border-color: #80bdff;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}
@media (max-width: 768px) {
    .table-responsive {
        font-size: 0.875rem;
    }
    .btn-lg {
        padding: 0.5rem 1rem;
        font-size: 1rem;
    }
    .row .col-md-3 {
        margin-bottom: 10px;
    }
    .d-flex {
        display: block !important;
    }
    .d-flex .btn {
        margin-top: 10px;
    }
    .card-body .row .col-md-3 {
        margin-bottom: 15px;
    }
}

/* Filter highlight */
.alert-info {
    border-left: 4px solid #17a2b8;
}

/* Button hover effects */
.btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    transition: all 0.2s ease;
}

/* Statistics cards animation */
.card {
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}
</style>
