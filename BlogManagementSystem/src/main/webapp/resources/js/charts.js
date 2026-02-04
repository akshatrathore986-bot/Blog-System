// ===== Simple Chart Utilities (Analytics) =====
function createBarChart(canvasId, data, labels) {
    const canvas = document.getElementById(canvasId);
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    const maxValue = Math.max(...data);
    const barWidth = canvas.width / data.length - 10;
    const scale = (canvas.height - 40) / maxValue;
    
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    
    data.forEach((value, index) => {
        const barHeight = value * scale;
        const x = index * (barWidth + 10) + 10;
        const y = canvas.height - barHeight - 20;
        
        // Draw bar
        ctx.fillStyle = '#667eea';
        ctx.fillRect(x, y, barWidth, barHeight);
        
        // Draw value
        ctx.fillStyle = '#000';
        ctx.font = '12px sans-serif';
        ctx.textAlign = 'center';
        ctx.fillText(value, x + barWidth / 2, y - 5);
        
        // Draw label
        ctx.fillText(labels[index], x + barWidth / 2, canvas.height - 5);
    });
}

function createLineChart(canvasId, data, labels) {
    const canvas = document.getElementById(canvasId);
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    const maxValue = Math.max(...data);
    const pointSpacing = canvas.width / (data.length - 1);
    const scale = (canvas.height - 40) / maxValue;
    
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    
    ctx.beginPath();
    ctx.strokeStyle = '#667eea';
    ctx.lineWidth = 2;
    
    data.forEach((value, index) => {
        const x = index * pointSpacing;
        const y = canvas.height - (value * scale) - 20;
        
        if (index === 0) {
            ctx.moveTo(x, y);
        } else {
            ctx.lineTo(x, y);
        }
        
        // Draw point
        ctx.fillStyle = '#667eea';
        ctx.beginPath();
        ctx.arc(x, y, 4, 0, 2 * Math.PI);
        ctx.fill();
    });
    
    ctx.stroke();
}

// Initialize charts on analytics page
document.addEventListener('DOMContentLoaded', function() {
    const viewsData = [120, 150, 180, 200, 250, 300, 320];
    const daysLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    if (document.getElementById('viewsChart')) {
        createLineChart('viewsChart', viewsData, daysLabels);
    }
    
    if (document.getElementById('postsChart')) {
        const postsData = [5, 8, 12, 10];
        const monthsLabels = ['Jan', 'Feb', 'Mar', 'Apr'];
        createBarChart('postsChart', postsData, monthsLabels);
    }
});
